//
//  BaseViewController.m
//  cochat
//
//  Created by 陈 胜 on 14-6-17.
//  Copyright (c) 2014年 Ruaho Technology. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 灰色背景
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:244/255.0f alpha:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
