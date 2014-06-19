//
//  CoTabBarController.h
//  mechat
//
//  Created by 陈 胜 on 14-6-19.
//  Copyright (c) 2014年 Ruaho Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoTabBarController : UITabBarController
- (UIButton *)buttonAtIndex:(NSUInteger)index;
- (void)badge:(NSInteger)index withValue:(NSInteger)value; // 显示消息条数徽章
- (void)badge:(NSUInteger)index; // 显示消息红点徽章
- (void)removeBadge:(NSUInteger)index; // 移除徽章
@end
