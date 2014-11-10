//
//  User.m
//  TwitterApp
//
//  Created by Gautam Sewani on 11/1/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "User.h"
#import "TwitterClient.h"

NSString *const UserDidLoginNotification = @"UserDidLoginNotification";
NSString *const UserDidLogoutNotification = @"UserDidLogoutNotification";

@implementation User
- (id) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    NSLog(@"User dictionary:%@",dictionary);
    if (self) {
        self.name = dictionary[@"name"];
        self.screenname = dictionary[@"screen_name"];
        self.profileImageUrl = dictionary[@"profile_image_url"];
        self.tagline = dictionary[@"description"];
        self.followerCount = [dictionary[@"followers_count"] intValue];
        self.followingCount = [dictionary[@"friends_count"] intValue];
        self.tweetCount = [dictionary[@"statuses_count"] intValue];

        self.dictionary = dictionary;
    }
    return self;
}

static User* _currentUser;
const NSString* kCurrentUser = @"current_user";

+ (User *) getCurrentUser {
    if (_currentUser == nil) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUser];
        if (data != nil) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            _currentUser = [[User alloc]initWithDictionary:dictionary];
        }
    }
    
    return _currentUser;
}

+ (void) setCurrentUser: (User *)user {
    _currentUser = user;
    if (_currentUser != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:_currentUser.dictionary options:0 error:NULL];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUser];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kCurrentUser];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) logout {
    [User setCurrentUser:nil];
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
    [[NSNotificationCenter defaultCenter]postNotificationName:UserDidLogoutNotification object:nil];
}
@end
