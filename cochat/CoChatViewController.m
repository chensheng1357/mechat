//
//  CoChatViewController.m
//  cochat
//
//  Created by 陈 胜 on 14-6-17.
//  Copyright (c) 2014年 Ruaho Technology. All rights reserved.
//

#import "CoChatViewController.h"
#import "CoTabBarController.h"

@interface CoChatViewController ()

@end

#define TITLE @"众信"
@implementation CoChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = TITLE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 设置当前信息条数
- (void)setInfoNumber:(NSUInteger)number
{
    NSMutableString *title = [NSMutableString stringWithString:TITLE];
    if (number != 0) {
        [title stringByAppendingFormat:@"(%lu)", (unsigned long)number];
    }
    self.navigationController.title = title;
}

@end
