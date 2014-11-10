//
//  TweetCell.h
//  TwitterApp
//
//  Created by Gautam Sewani on 11/1/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *tweeterImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *handle;
@property (weak, nonatomic) IBOutlet UILabel *timeElapsed;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (nonatomic, strong) Tweet *tweet;
@property (nonatomic, strong) UIViewController* parentNavigationViewController;
- (void) loadTweet:(Tweet *)tweet;
- (NSString *)getTimeElapsedForDate:(NSDate *)date;
@end
