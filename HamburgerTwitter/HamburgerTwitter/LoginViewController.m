//
//  LoginViewController.m
//  TwitterApp
//
//  Created by Gautam Sewani on 10/30/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "HamburgerViewController.h"
#import "TweetViewController.h"
#import "MenuViewController.h"

@interface LoginViewController ()
- (IBAction)onLogin:(id)sender;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)onLogin:(id)sender {
    NSLog(@"in onlogin");
    [[TwitterClient sharedInstance] loginWithCompletetion:^(User *user, NSError *error) {
        // do something
        if (user != nil) {
            NSLog(@"Login success");
            
            HamburgerViewController *hvc = [[HamburgerViewController alloc]init];
            TweetViewController *tvc = [[TweetViewController alloc]init];
            tvc.title = @"Home";
            hvc.leftViewController = [[MenuViewController alloc]init];
            hvc.contentViewController = tvc;
            [self presentViewController:hvc animated:YES completion:^{
                NSLog(@"presenting tweet view controller");
            }];
            
            /*TweetViewController* tvc = [[TweetViewController alloc]init];
            UINavigationController* nvc = [[UINavigationController alloc]initWithRootViewController:tvc];
            [self presentViewController:nvc animated:YES completion:^{
                NSLog(@"presenting tweet view controller");
            }];*/
        } else {
            // show error screen
            NSLog(@"Error in logging in!");
        }
    }];
}

@end
