//
//  CoSearchBarTableViewController.m
//  mechat
//
//  Created by 陈 胜 on 14-6-25.
//  Copyright (c) 2014年 Ruaho Technology. All rights reserved.
//

#import "CoSearchBarTableViewController.h"

@interface CoSearchBarTableViewController ()
@property (nonatomic, strong, readwrite) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *strongSearchDisplayController;

@property (nonatomic, copy) NSArray *famousPersons;
@property (nonatomic, copy) NSArray *sections;

@property (nonatomic, copy) NSArray *filteredPersons;
@property (nonatomic, copy) NSString *currentSearchString;
@end

@implementation CoSearchBarTableViewController

- (id)initWithSectionIndexes:(BOOL)showSectionIndexes
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _showSectionIndexes = showSectionIndexes;
        
        // 加载plist数据
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Top100FamousPersons" ofType:@"plist"];
        _famousPersons = [[NSArray alloc] initWithContentsOfFile:path];
        
        if (showSectionIndexes) {
            UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
            
            NSMutableArray *unsortedSections = [[NSMutableArray alloc] initWithCapacity:[[collation sectionTitles] count]];
            for (NSUInteger i = 0; i < [[collation sectionTitles] count]; i++) {
                [unsortedSections addObject:[NSMutableArray array]];
            }
            
            for (NSString *personName in self.famousPersons) {
                NSInteger index = [collation sectionForObject:personName collationStringSelector:@selector(description)];
                [[unsortedSections objectAtIndex:index] addObject:personName];
            }
            
            NSMutableArray *sortedSections = [[NSMutableArray alloc] initWithCapacity:unsortedSections.count];
            for (NSMutableArray *section in unsortedSections) {
                [sortedSections addObject:[collation sortedArrayFromArray:section collationStringSelector:@selector(description)]];
            }
            
            self.sections = sortedSections;
        }
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置搜索条设置
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.delegate = self;
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"取消"];
    
    [self.searchBar sizeToFit];
    
    self.tableView.tableHeaderView = self.searchBar;
    self.strongSearchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    self.strongSearchDisplayController.searchResultsDataSource = self;
    self.strongSearchDisplayController.searchResultsDelegate = self;
    self.strongSearchDisplayController.delegate = self;
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    if ([searchBar isEqual:self.searchBar]) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    if ([searchBar isEqual:self.searchBar]) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
    return YES;
}

#pragma mark - TableView Delegate and DataSource

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.tableView && self.showSectionIndexes) {
        return [[NSArray arrayWithObject:UITableViewIndexSearch] arrayByAddingObjectsFromArray:[[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
    } else {
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView && self.showSectionIndexes) {
        if ([[self.sections objectAtIndex:section] count] > 0) {
            return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if ([title isEqualToString:UITableViewIndexSearch]) {
        return NSNotFound;
    } else {
        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index] - 1; // -1 because we add the search symbol
    }
}


// 总共有多少节
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.showSectionIndexes) {
        return self.sections.count;
    } else {
        return 1;
    }
}

// 每一节都有几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView]) {
        if (self.showSectionIndexes) {
            return [[self.sections objectAtIndex:section] count];
        } else {
            return self.famousPersons.count;
        }
    } else { // 否则显示搜索出来的数据
        return [self.filteredPersons count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.tableViewCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.tableViewCellIdentifier];
    }
    
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:18]];
    if ([tableView isEqual:self.tableView]) {
        if (self.showSectionIndexes) {
            cell.textLabel.text = [[self.sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        } else {
            cell.textLabel.text = [self.famousPersons objectAtIndex:indexPath.row];
        }
    } else {
        cell.textLabel.text = [self.filteredPersons objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Search Delegate

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    self.filteredPersons = nil;
    self.currentSearchString = @"";
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    self.filteredPersons = nil;
    self.currentSearchString = nil;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    if (searchString.length > 0) {
        // 在结果中搜索，速度更快
        NSArray *personsToSearch = self.famousPersons;
        if (self.currentSearchString.length > 0 && [searchString rangeOfString:self.currentSearchString].location == 0) {
            personsToSearch = self.filteredPersons;
        }
        
        self.filteredPersons = [personsToSearch filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchString]];
    } else {
        self.filteredPersons = self.famousPersons;
    }
    
    self.currentSearchString = searchString;
    
    return YES;
}

@end
