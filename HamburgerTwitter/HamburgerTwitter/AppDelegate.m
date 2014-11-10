//
//  AppDelegate.m
//  HamburgerTwitter
//
//  Created by Gautam Sewani on 11/8/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "AppDelegate.h"
#import "HamburgerViewController.h"
#import "MenuViewController.h"
#import "LoginViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "TweetViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"Starting app");
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout) name:UserDidLogoutNotification object:nil];
    UIViewController *rvc;
    if ([User getCurrentUser] == nil) {
        rvc = [[LoginViewController alloc]init];
    } else {
        HamburgerViewController *hvc = [HamburgerViewController sharedInstance];
        TweetViewController *tvc = [[TweetViewController alloc]init];
        tvc.title = @"Home";
        hvc.leftViewController = [[MenuViewController alloc]init];
        hvc.contentViewController = tvc;
        rvc = hvc;
    }
    self.window.rootViewController = rvc;    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[TwitterClient sharedInstance] openUrl:url];
    return YES;
}

- (void) userDidLogout {
    self.window.rootViewController = [[LoginViewController alloc]init];
}

@end
