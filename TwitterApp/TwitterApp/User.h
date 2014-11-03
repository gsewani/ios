//
//  User.h
//  TwitterApp
//
//  Created by Gautam Sewani on 11/1/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const UserDidLoginNotification;
extern NSString *const UserDidLogoutNotification;

@interface User : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenname;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *tagline;
@property (nonatomic, strong) NSDictionary *dictionary;

- (id) initWithDictionary:(NSDictionary *)dictionary;
+ (User *) getCurrentUser;
+ (void) setCurrentUser: (User *)user;
+ (void) logout;

@end
