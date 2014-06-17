//
//  CoTabBarController.m
//  cochat
//
//  Created by 陈 胜 on 14-6-17.
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

@interface CoTabBarController ()
@property (nonatomic, strong)UIView *tabBarView;
@end

@implementation CoTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatCustomTabBar];
    [self createControllers];
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
    self.tabBar.hidden = YES;
    self.tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 49, 640, 49)];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 640, 49)];
    [bgImgView setImage:[UIImage imageNamed:@"tabbarBkg"]];
    [self.tabBarView addSubview:bgImgView];
    NSUInteger tabBarCount = [TabBarTitles count];
    for (int i = 0; i < tabBarCount; i++) {
        UIButton *button = [self createButton:i];
        button.tag = 100 + i;
        [self.tabBarView addSubview:button];
    }
    [self.view addSubview:self.tabBarView];
}

- (UIButton *)createButton:(int)index
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(80 * index, 0, 80, 49)];
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
    UIButton *currentButton = (UIButton *)[self.tabBarView viewWithTag:(100 + self.selectedIndex)];
    if (![button isEqual:currentButton]) { // 点击是其它按钮
        [currentButton setBackgroundImage:[UIImage imageNamed:[NormalImages objectAtIndex:self.selectedIndex]]
                                 forState:UIControlStateNormal];
        [currentButton setTitleColor:[UIColor grayColor]
                            forState:UIControlStateNormal];
        
        self.selectedIndex = button.tag - 100; // 取得按钮索引;
        [button setBackgroundImage:[UIImage imageNamed:[SelectedImages objectAtIndex:self.selectedIndex]]
                          forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor]
                     forState:UIControlStateNormal];
    }
}

// 获取指定索引的按钮
- (UIButton *)buttonAtIndex:(NSUInteger)index
{
    if (index < 4) {
        return (UIButton *)[self.tabBarView viewWithTag:index];
    }
    return  nil;
}

// 显示消息条数徽章
- (void)badge:(NSInteger)index withValue:(NSInteger)value
{
    UIButton *button = (UIButton *)[self.tabBarView viewWithTag:(100 + index)];
    MKNumberBadgeView *badge = (MKNumberBadgeView *)[button viewWithTag:(10 + index)];
    if (!badge) {
        badge = [[MKNumberBadgeView alloc]initWithFrame:CGRectMake(button.frame.size.width - 42, 0, 32, 20)];
        badge.hideWhenZero = YES;
        [self setUpBadge:badge atIndex:index];
        [button addSubview:badge];
    }
    badge.value = value;
}

// 显示消息红点徽章
- (void)badge:(NSUInteger)index
{
    UIButton *button = (UIButton *)[self.tabBarView viewWithTag:(100 + index)];
    MKNumberBadgeView *badge = (MKNumberBadgeView *)[button viewWithTag:(10 + index)];
    if (!badge) {
        badge = [[MKNumberBadgeView alloc]initWithFrame:CGRectMake(button.frame.size.width - 31, 5, 10, 10)];
        [self setUpBadge:badge atIndex:index];
        badge.value = 0;
        [button addSubview:badge];
    }
}

// 徽章设置
- (void)setUpBadge:(MKNumberBadgeView *)badge atIndex:(NSInteger)index
{
    badge.strokeWidth = 0;
    badge.shadow = NO;
    badge.shine = NO;
    badge.font = [UIFont boldSystemFontOfSize:11];
    badge.tag = 10 + index;
}

// 移除徽章
- (void)removeBadge:(NSUInteger)index
{
    UIButton *button = (UIButton *)[self.tabBarView viewWithTag:(100 + index)];
    [[button viewWithTag:(10 + index)]removeFromSuperview];
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
