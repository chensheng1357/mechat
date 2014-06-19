//
//  CoChatViewController.m
//  cochat
//
//  Created by 陈 胜 on 14-6-17.
//  Copyright (c) 2014年 Ruaho Technology. All rights reserved.
//

#import "CoChatViewController.h"
#import "CoTabBarController.h"
#import "TestViewController.h"

@interface CoChatViewController ()

@end

#define TITLE @"众信"
@implementation CoChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setInfoNumber:6];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                          target:self
                                                                                          action:@selector(go:)];
}

- (void)go:(UIBarButtonItem *)sender
{
    TestViewController *testViewController = [[TestViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:testViewController animated:YES];
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
    if (number > 0) {
        if (number < 100) {
            [title appendString:[NSString stringWithFormat:@"(%lu)", (unsigned long)number]];
        } else {
            [title appendString:@"(99+)"];
        }
    }
    self.title = title;
}

@end
