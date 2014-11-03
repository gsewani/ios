//
//  TweetDetailsViewController.m
//  TwitterApp
//
//  Created by Gautam Sewani on 11/2/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "NewTweetViewController.h"
#import "UIImageView+AFNetworking.h"

@interface TweetDetailsViewController ()

@end

@implementation TweetDetailsViewController

- (id) initWithTweet:(Tweet *)tweet {
    self = [super init];
    if (self) {
        self.tweet = tweet;
    }
    [self.tweeterImage setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    self.favoriteIcon = [UIImage imageNamed:@"favorite.png"];
    self.favoriteOnIcon = [UIImage imageNamed:@"favorite_on.png"];
    self.retweetIcon = [UIImage imageNamed:@"retweet.png"];
    self.retweetOnIcon = [UIImage imageNamed:@"retweet_on.png"];
    [self setFavoriteState];
    [self setRetweetState];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name.text = self.tweet.user.name;
    self.handle.text = self.tweet.user.screenname;
    self.tweetText.text = self.tweet.text;
    [self.tweeterImage setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    self.timestampLabel.text = [self.tweet getTimeElapsed];
    [self setFavoriteState];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == self.favoriteImageView)
    {
        [[TwitterClient sharedInstance] favoriteStatusToggleForTweet:self.tweet withCompletion:^(NSError *error) {
            if (error == nil) {
                [self setFavoriteState];
            } else {
                NSLog(@"Error in favoriting");
            }
        }];
    } else if ([touch view] == self.replyImageView) {
        NSLog(@"Image touched");
        NewTweetViewController* ntvc = [[NewTweetViewController alloc]init];
        ntvc.initialText = [NSString stringWithFormat:@"@%@", self.tweet.user.screenname];
        UINavigationController* nvc = [[UINavigationController alloc]initWithRootViewController:ntvc];
        [self presentViewController:nvc animated:YES  completion:^{
            NSLog(@"completion");
        }];
    } else if ([touch view] == self.retweetImageView)
    {
        [[TwitterClient sharedInstance] retweetTweet:self.tweet withCompletion:^(NSError *error) {
            if (error == nil) {
                [self setRetweetState];
            } else {
                NSLog(@"Error in favoriting");
            }
        }];
    }
    
}

- (void)setFavoriteState {
    if (self.tweet.favorited) {
        self.favoriteImageView.image = self.favoriteOnIcon;
    } else {
        self.favoriteImageView.image = self.favoriteIcon;
    }
    if (self.tweet.favoriteCount) {
        self.favoriteCount.text = [NSString stringWithFormat:@"%ld", self.tweet.favoriteCount];
    }
}

- (void)setRetweetState {
    if (self.tweet.retweeted) {
        self.retweetImageView.image = self.retweetOnIcon;
    } else {
        self.retweetImageView.image = self.retweetIcon;
    }
    if (self.tweet.retweetCount) {
        self.retweetCountLabel.text = [NSString stringWithFormat:@"%ld", self.tweet.retweetCount];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
