//
//  CoChatViewController.m
//  mechat
//
//  Created by 陈 胜 on 14-6-19.
//  Copyright (c) 2014年 Ruaho Technology. All rights reserved.
//

#import "CoChatViewController.h"

@interface CoChatViewController ()
@end

#define TITLE @"众信"
@implementation CoChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    
    self.navigationItem.title = @"众信";
    [self setInfoNumber:6];
    
    // 使得一开始看不见搜索条
    self.tableView.contentOffset = CGPointMake(0, CGRectGetHeight(self.searchBar.bounds));
}

- (NSString *)tableViewCellIdentifier
{
    return @"ChatTableViewCells";
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
