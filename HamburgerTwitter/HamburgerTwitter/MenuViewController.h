//
//  MenuViewController.h
//  HamburgerTwitter
//
//  Created by Gautam Sewani on 11/8/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HamburgerViewController.h"
@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *menuTable;
@property (weak, atomic) HamburgerViewController *hvc;
@end
