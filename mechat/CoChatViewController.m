//
//  CoChatViewController.m
//  mechat
//
//  Created by 陈 胜 on 14-6-19.
//  Copyright (c) 2014年 Ruaho Technology. All rights reserved.
//

#import "CoChatViewController.h"

@interface CoChatViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *strongSearchDisplayController;
@property (nonatomic, copy) NSArray *famousPersons;
@end

#define TITLE @"众信"
@implementation CoChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 加载plist数据c
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Top100FamousPersons" ofType:@"plist"];
    self.famousPersons = [[NSArray alloc] initWithContentsOfFile:path];
    
    self.navigationItem.title = @"众信";
    [self setInfoNumber:6];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ChatTableViewCellIdentifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.tableView];
    
    // 设置搜索条的大小
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

#pragma mark - TableView Delegate and DataSource

// 总共有多少节
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 每一节都有几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.famousPersons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ChatTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ChatTableViewCellIdentifier];
    }
    
    if (tableView == self.tableView) {
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:18]];
        cell.textLabel.text = self.famousPersons[indexPath.row];
    } else {
//        cell.textLabel.text = [self.filteredPersons objectAtIndex:indexPath.row];
        cell.textLabel.text = @"测试";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - set title

// 设置当前信息条数
- (void)setInfoNumber:(NSUInteger)number
{
    NSMutableString *title = [NSMutableString stringWithString:TITLE];
    if (number > 0) {
        if (number < 100) {
            [title appendString:[NSString stringWithFormat:@"(%lu)", (unsigned long)number]];
        } else {
            [title appendString:@"(99+)"];
        }
    }
    self.navigationItem.title = title;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
   
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
