//
//  LoginViewController.m
//  ParseChat
//
//  Created by Gautam Sewani on 10/29/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/PFUser.h>
#import "ChatViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
- (IBAction)onSignUp:(id)sender;
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

- (IBAction)onSignUp:(id)sender {
    PFUser *user = [PFUser user];
    user.username = self.username.text;
    user.password = self.password.text;
    user.email = @"gautam@example.com";
    
    // other fields can be set just like with PFObject
    user[@"phone"] = @"415-392-0202";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Sign up complete");
            // Hooray! Let them use the app now.
        } else {
            NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
        }
    }];
}

- (IBAction)onLogin:(id)sender {
    [PFUser logInWithUsernameInBackground:self.username.text password:self.password.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {

                                            
                                            [self presentViewController:[[ChatViewController alloc]init] animated:YES  completion:^{
                                                NSLog(@"completion");
                                            }];
                                            // Do stuff after successful login.
                                            NSLog(@"Log in succesful");
                                        } else {
                                            // The login failed. Check error to see why.
                                            NSLog(@"Error");
                                        }
                                    }];
}
@end
