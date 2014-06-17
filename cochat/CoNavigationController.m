//
//  CoNavigationController.m
//  cochat
//
//  Created by 陈 胜 on 14-6-17.
//  Copyright (c) 2014年 Ruaho Technology. All rights reserved.
//

#import "CoNavigationController.h"

@interface CoNavigationController ()

@end

@implementation CoNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置背景
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbarbg_ios7"]
                             forBarMetrics:UIBarMetricsDefault];
    
    // 设置title属性
    NSDictionary *titleAttrDict = @{
                                    NSForegroundColorAttributeName:[UIColor whiteColor],
                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:20]};
    self.navigationBar.titleTextAttributes = titleAttrDict;
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
