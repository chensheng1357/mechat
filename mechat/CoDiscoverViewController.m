//
//  CoDiscoverViewController.m
//  mechat
//
//  Created by 陈 胜 on 14-6-19.
//  Copyright (c) 2014年 Ruaho Technology. All rights reserved.
//

#import "CoDiscoverViewController.h"

@interface CoDiscoverViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CoDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"发现";
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ContactsTableViewCellIdentifier];
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
            return 2;
            break;
        }
            
        case 2: {
            return 1;
            break;
        }
            
        case 3: {
            return 2;
            break;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if ([tableView isEqual:self.tableView]) {
        cell = [tableView dequeueReusableCellWithIdentifier:ContactsTableViewCellIdentifier forIndexPath:indexPath];
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:18]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.section) {
            case 0: {
                cell.textLabel.text = @"同事圈";
                cell.imageView.image = [UIImage imageNamed:@"ff_IconShowAlbum"];
                break;
            }
            case 1: {
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"扫一扫";
                    cell.imageView.image = [UIImage imageNamed:@"ff_IconQRCode"];
                } else if (indexPath.row == 1) {
                    cell.textLabel.text = @"摇一摇";
                    cell.imageView.image = [UIImage imageNamed:@"ff_IconShake"];
                }
                break;
            }
            case 2: {
                cell.textLabel.text = @"附近的人";
                cell.imageView.image = [UIImage imageNamed:@"ff_IconLocationService"];
                break;
            }
            case 3: {
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"购物";
                    cell.imageView.image = [UIImage imageNamed:@"CreditCard_ShoppingBag"];
                } else if (indexPath.row == 1) {
                    cell.textLabel.text = @"游戏";
                    cell.imageView.image = [UIImage imageNamed:@"MoreGame"];
                }
                break;
            }
        }
    }
    return cell;
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
