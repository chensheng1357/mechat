//
//  CoTabBarController.m
//  mechat
//
//  Created by 陈 胜 on 14-6-19.
//  Copyright (c) 2014年 Ruaho Technology. All rights reserved.
//

#import "CoTabBarController.h"
#import "CoChatViewController.h"
#import "CoContactsViewController.h"
#import "CoDiscoverViewController.h"
#import "CoMeViewController.h"
#import "CoNavigationController.h"
#import "MKNumberBadgeView.h"

#define NormalImages @[@"tabbar_mainframe",@"tabbar_contacts",@"tabbar_discover",@"tabbar_me"]
#define SelectedImages @[@"tabbar_mainframeHL",@"tabbar_contactsHL",@"tabbar_discoverHL",@"tabbar_meHL"]
#define TabBarTitles @[@"众信", @"通讯录", @"发现", @"我"]
#define ButtonTagFlag 100
#define BadgeTagFlag 10

@interface CoTabBarController ()
@end

@implementation CoTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createControllers];
    [self creatCustomTabBar];
}

- (void)createControllers
{
    CoChatViewController *coChatViewController = [[CoChatViewController alloc]init];
    CoContactsViewController *coContactsViewController = [[CoContactsViewController alloc]init];
    CoDiscoverViewController *coDiscoverViewController = [[CoDiscoverViewController alloc]init];
    CoMeViewController *coMeViewController = [[CoMeViewController alloc]init];
    
    CoNavigationController *coChatNavigationController =
    [[CoNavigationController alloc]initWithRootViewController:coChatViewController];
    
    CoNavigationController *coContactsNavigationController =
    [[CoNavigationController alloc]initWithRootViewController:coContactsViewController];
    
    CoNavigationController *coDiscoverNavigationController =
    [[CoNavigationController alloc]initWithRootViewController:coDiscoverViewController];
    
    CoNavigationController *coMeNavigationController =
    [[CoNavigationController alloc]initWithRootViewController:coMeViewController];
    
    [self setViewControllers:@[
                               coChatNavigationController,
                               coContactsNavigationController,
                               coDiscoverNavigationController,
                               coMeNavigationController]];
}

- (void)creatCustomTabBar
{
    NSUInteger tabBarCount = [TabBarTitles count];
    for (int i = 0; i < tabBarCount; i++) {
        UIButton *button = [self createButton:i];
        button.tag = 100 + i;
        [self.tabBar insertSubview:button atIndex:i];
        [self.tabBar bringSubviewToFront:button];
    }
}

- (UIButton *)createButton:(int)index
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = self.tabBar.frame;
    [button setFrame:CGRectMake(frame.size.width / 4 * index, 0, frame.size.width / 4, frame.size.height)];
    [button setTitle:TabBarTitles[index] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -30, 0)]; // 设置文字位置
    button.adjustsImageWhenHighlighted = NO; // 可以取消掉长按按钮时出现的深色背景
    UIImage *image = [UIImage imageNamed:NormalImages[index]];
    UIImage *selectedImage = [UIImage imageNamed:SelectedImages[index]];
    [button addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    if (index == 0) {
        self.selectedIndex = 0;
        [button setBackgroundImage:selectedImage
                          forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor]
                     forState:UIControlStateNormal];
    } else {
        [button setBackgroundImage:image
                          forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor]
                     forState:UIControlStateNormal];
    }
    
    return button;
}

-(void)clickedButton:(UIButton *)button
{
    UIButton *currentButton = (UIButton *)[self.tabBar viewWithTag:(ButtonTagFlag + self.selectedIndex)];
    if (![button isEqual:currentButton]) { // 点击是其它按钮
        [currentButton setBackgroundImage:[UIImage imageNamed:[NormalImages objectAtIndex:self.selectedIndex]]
                                 forState:UIControlStateNormal];
        [currentButton setTitleColor:[UIColor grayColor]
                            forState:UIControlStateNormal];
        
        self.selectedIndex = button.tag - ButtonTagFlag; // 取得按钮索引;
        [button setBackgroundImage:[UIImage imageNamed:[SelectedImages objectAtIndex:self.selectedIndex]]
                          forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor]
                     forState:UIControlStateNormal];
    }
}

// 获取指定索引的按钮
- (UIButton *)buttonAtIndex:(NSUInteger)index
{
    if (index < [TabBarTitles count]) {
        return (UIButton *)[self.tabBar viewWithTag:index];
    }
    return  nil;
}

// 显示消息条数徽章
- (void)badge:(NSInteger)index withValue:(NSInteger)value
{
    UIButton *button = (UIButton *)[self.tabBar viewWithTag:(ButtonTagFlag + index)];
    MKNumberBadgeView *badge = (MKNumberBadgeView *)[button viewWithTag:(BadgeTagFlag + index)];
    if (!badge) {
        badge = [[MKNumberBadgeView alloc]initWithFrame:CGRectMake(button.frame.size.width - 42, 0, 32, 20)];
        badge.hideWhenZero = YES;
        badge.font = [UIFont boldSystemFontOfSize:12];
        [self setupBadge:badge atIndex:index];
        [button addSubview:badge];
    }
    badge.value = value;
}

// 显示消息红点徽章
- (void)badge:(NSUInteger)index
{
    UIButton *button = (UIButton *)[self.tabBar viewWithTag:(ButtonTagFlag + index)];
    MKNumberBadgeView *badge = (MKNumberBadgeView *)[button viewWithTag:(BadgeTagFlag + index)];
    if (!badge) {
        badge = [[MKNumberBadgeView alloc]initWithFrame:CGRectMake(button.frame.size.width - 31, 5, 10, 10)];
        badge.font = [UIFont boldSystemFontOfSize:5];
        [self setupBadge:badge atIndex:index];
        badge.value = NO;
        [button addSubview:badge];
    }
}

// 徽章设置
- (void)setupBadge:(MKNumberBadgeView *)badge atIndex:(NSInteger)index
{
    badge.strokeWidth = 0;
    badge.shadow = NO;
    badge.shine = NO;
    badge.tag = BadgeTagFlag + index;
}

// 移除徽章
- (void)removeBadge:(NSUInteger)index
{
    UIButton *button = (UIButton *)[self.tabBar viewWithTag:(ButtonTagFlag + index)];
    [[button viewWithTag:(BadgeTagFlag + index)]removeFromSuperview];
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