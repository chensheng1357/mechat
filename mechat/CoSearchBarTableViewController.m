//
//  CoSearchBarTableViewController.m
//  mechat
//
//  Created by 陈 胜 on 14-6-25.
//  Copyright (c) 2014年 Ruaho Technology. All rights reserved.
//

#import "CoSearchBarTableViewController.h"

@interface CoSearchBarTableViewController ()<UISearchBarDelegate, UISearchDisplayDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
@property (nonatomic, strong, readwrite) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *strongSearchDisplayController;

@property (nonatomic, copy) NSArray *famousPersons;

@property(nonatomic, copy) NSArray *filteredPersons;
@property(nonatomic, copy) NSString *currentSearchString;
@end

@implementation CoSearchBarTableViewController

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
    
    // 加载plist数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Top100FamousPersons" ofType:@"plist"];
    self.famousPersons = [[NSArray alloc] initWithContentsOfFile:path];
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

// 总共有多少节
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 每一节都有几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView]) {
        return [self.famousPersons count];
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
    
    if ([tableView isEqual:self.tableView]) {
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:18]];
        cell.textLabel.text = self.famousPersons[indexPath.row];
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
