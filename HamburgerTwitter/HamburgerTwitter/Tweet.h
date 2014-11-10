//
//  Tweet.h
//  TwitterApp
//
//  Created by Gautam Sewani on 11/1/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Tweet : NSObject
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *user;
//@property (nonatomic, strong) NSString *tagline;
- (id) initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)tweetsWithArray:(NSArray *)array;
@property (nonatomic) NSInteger favoriteCount;
@property (nonatomic) BOOL favorited;
@property (nonatomic) NSInteger retweetCount;
@property (nonatomic) BOOL retweeted;
@property (nonatomic, strong) NSString* id;
- (NSString *)getTimeElapsed;
@end
