//
//  CoTableViewController.m
//  mechat
//
//  Created by 陈 胜 on 14-6-25.
//  Copyright (c) 2014年 Ruaho Technology. All rights reserved.
//

#import "CoTableViewController.h"

@interface CoTableViewController ()
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, assign) NSInteger style;
@end

@implementation CoTableViewController

// 使用UITableViewStyle来构造Table View
- (instancetype)initWithTableStyle:(UITableViewStyle)style
{
    self.style = style;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat statusHeight = [[UIApplication sharedApplication]statusBarFrame].size.height;
    CGFloat navigationHeight = self.navigationController.navigationBar.frame.size.height;
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, screenHeight - (statusHeight + navigationHeight));
    self.tableView = [[UITableView alloc]initWithFrame:frame style:self.style];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:self.tableViewCellIdentifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
