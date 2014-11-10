//
//  NewTweetViewController.m
//  TwitterApp
//
//  Created by Gautam Sewani on 11/2/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "NewTweetViewController.h"
#import "TwitterClient.h"
#import "user.h"
#import "UIImageView+AFNetworking.h"

@interface NewTweetViewController ()

@end

@implementation NewTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    User* currentUser = [User getCurrentUser];
    [self.tweeterImage setImageWithURL:[NSURL URLWithString:currentUser.profileImageUrl]];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet)];
    self.navigationItem.rightBarButtonItem = rightButton;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
                                      
    self.navigationItem.leftBarButtonItem = cancelButton;
    if (self.initialText != nil) {
        self.tweetTextView.text = self.initialText;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) onTweet {
    [[TwitterClient sharedInstance] postTweet:self.tweetTextView.text withCompletion:^(NSError *error) {
        if (error == nil) {
            NSLog(@"Tweeted!");
        } else {
            NSLog(@"%@", error);
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) onCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
