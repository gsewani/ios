//
//  TweetDetailsViewController.h
//  TwitterApp
//
//  Created by Gautam Sewani on 11/2/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetDetailsViewController : UIViewController
@property (nonatomic, strong) Tweet *tweet;
- (id) initWithTweet:(Tweet *)tweet;
@property (weak, nonatomic) IBOutlet UIImageView *tweeterImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *handle;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImageView;
@property (strong, nonatomic) UIImage *favoriteIcon;
@property (strong, nonatomic) UIImage *favoriteOnIcon;
@property (strong, nonatomic) UIImage *retweetIcon;
@property (strong, nonatomic) UIImage *retweetOnIcon;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCount;
@property (weak, nonatomic) IBOutlet UIImageView *replyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImageView;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end
