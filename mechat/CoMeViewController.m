//
//  CoMeViewController.m
//  mechat
//
//  Created by 陈 胜 on 14-6-19.
//  Copyright (c) 2014年 Ruaho Technology. All rights reserved.
//

#import "CoMeViewController.h"

@interface CoMeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CoMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我";
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MeTableViewCellIdentifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    
    [self.tableView sizeToFit];
    
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
        if (indexPath.section == 0) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MeTableViewCellIdentifier];
            [cell.detailTextLabel setFont:[UIFont systemFontOfSize:14]];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:MeTableViewCellIdentifier forIndexPath:indexPath];
        }
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:18]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.section) {
            case 0: {
                cell.textLabel.text = @"陈胜";
                cell.detailTextLabel.text = @"众信号：chensheng@ruaho.com";
                NSString *path = [[NSBundle mainBundle] pathForResource:@"header" ofType:@"jpeg"];
                UIImage *image = [UIImage imageWithContentsOfFile:path];
                cell.imageView.image = [self resizeImage:image forSize:CGSizeMake(68, 68)];;
                
                // 设置图片圆角
                cell.imageView.layer.cornerRadius = 5;
                cell.imageView.layer.masksToBounds = YES;
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
        return 0.0f;
    }
    
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 设置图片大小
- (UIImage *)resizeImage:(UIImage *)image forSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGRect imageRect = CGRectMake(0.0, 0.0, size.width, size.height);
    [image drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
