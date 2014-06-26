//
//  CoSearchBarTableViewController.h
//  mechat
//
//  Created by 陈 胜 on 14-6-25.
//  Copyright (c) 2014年 Ruaho Technology. All rights reserved.
//

#import "CoTableViewController.h"

@interface CoSearchBarTableViewController : CoTableViewController<UISearchBarDelegate, UISearchDisplayDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
@property (nonatomic, strong, readonly) UISearchBar *searchBar;
@property (nonatomic, assign, readonly) BOOL showSectionIndexes;

- (id)initWithSectionIndexes:(BOOL)showSectionIndexes;

@end
