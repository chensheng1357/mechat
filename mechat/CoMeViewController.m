//
//  CoMeViewController.m
//  mechat
//
//  Created by 陈 胜 on 14-6-19.
//  Copyright (c) 2014年 Ruaho Technology. All rights reserved.
//

#import "CoMeViewController.h"

@interface CoMeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation CoMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我";
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat statusHeight = [[UIApplication sharedApplication]statusBarFrame].size.height;
    CGFloat navigationHeight = self.navigationController.navigationBar.frame.size.height;
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, screenHeight - (statusHeight + navigationHeight));
    self.tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MeTableViewCellIdentifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - TableView Delegate and DataSource

// 总共有多少节
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

// 每一节都有几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: {
            return 1;
            break;
        }
            
        case 1: {
            return 3;
            break;
        }
            
        case 2: {
            return 1;
            break;
        }
            
        case 3: {
            return 1;
            break;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if ([tableView isEqual:self.tableView]) {
        cell = [tableView dequeueReusableCellWithIdentifier:MeTableViewCellIdentifier forIndexPath:indexPath];
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:18]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.section) {
            case 0: {
                cell.textLabel.text = @"陈胜";
                cell.imageView.image = [UIImage imageNamed:@"ff_IconShowAlbum"];
                break;
            }
            case 1: {
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"我的相册";
                    cell.imageView.image = [UIImage imageNamed:@"MoreMyAlbum"];
                } else if (indexPath.row == 1) {
                    cell.textLabel.text = @"我的收藏";
                    cell.imageView.image = [UIImage imageNamed:@"MoreMyFavorites"];
                } else if (indexPath.row == 2) {
                    cell.textLabel.text = @"我的银行卡";
                    cell.imageView.image = [UIImage imageNamed:@"MoreMyBankCard"];
                }
                break;
            }
            case 2: {
                cell.textLabel.text = @"表情";
                cell.imageView.image = [UIImage imageNamed:@"MoreExpressionShops"];
                break;
            }
            case 3: {
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"设置";
                    cell.imageView.image = [UIImage imageNamed:@"MoreSetting"];
                }
                break;
            }
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 88.0f;
    }
    return 44.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0){
        return 15.0f;
    }
    
    return 10.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 3) {
        return 30.0f;
    }
    
    return 10.0f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
