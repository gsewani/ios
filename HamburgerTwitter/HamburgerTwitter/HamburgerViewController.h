//
//  HamburgerViewController.h
//  HamburgerTwitter
//
//  Created by Gautam Sewani on 11/8/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HamburgerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *leftView;

@property (nonatomic, strong) UIViewController *contentViewController;
@property (nonatomic, strong) UIViewController *leftViewController;

- (void) showContent;
+ (HamburgerViewController *)sharedInstance;
@end
