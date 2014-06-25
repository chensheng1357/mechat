//
//  CoTableViewController.h
//  mechat
//
//  Created by 陈 胜 on 14-6-25.
//  Copyright (c) 2014年 Ruaho Technology. All rights reserved.
//

#import "BaseViewController.h"

static NSString *TableViewCellIdentifier = @"TableViewCells";
@interface CoTableViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong) NSString *tableViewCellIdentifier;

- (instancetype)initWithTableViewStyle:(UITableViewStyle)style;

@end
