//
//  ProfileViewController.m
//  HamburgerTwitter
//
//  Created by Gautam Sewani on 11/9/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"url:%@",self.user.profileImageUrl);
    [self.profilePicImage setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    self.headerView.backgroundColor = [UIColor colorWithRed:0 green:132.0/255 blue:180.0/255 alpha:1];
    self.nameLabel.text = self.user.name;
    self.handleLabel.text = [NSString stringWithFormat:@"@%@", self.user.screenname];

    self.tweetCount.text = [NSString stringWithFormat:@"%d", self.user.tweetCount];
    self.followerCount.text = [NSString stringWithFormat:@"%d", self.user.followerCount];
    self.followingCount.text = [NSString stringWithFormat:@"%d", self.user.followingCount];
    
    // Do any additional setup after loading the view from its nib.
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

@end
