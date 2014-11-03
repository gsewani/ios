//
//  TweetViewController.h
//  TwitterApp
//
//  Created by Gautam Sewani on 11/1/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tweetTable;
@property (nonatomic, strong) NSArray *tweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end
