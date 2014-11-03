//
//  Tweet.m
//  TwitterApp
//
//  Created by Gautam Sewani on 11/1/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "Tweet.h"
#import "User.h"
#import "TwitterClient.h"

@implementation Tweet
- (id) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.text = dictionary[@"text"];
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [formatter dateFromString:createdAtString];
        self.id = dictionary[@"id"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
    }
    return self;
}

- (NSString *)getTimeElapsed {
    NSTimeInterval timeSinceDate = [[NSDate date] timeIntervalSinceDate:self.createdAt];
    if(timeSinceDate < 24.0 * 60.0 * 60.0) {
        NSUInteger hoursSinceDate = (NSUInteger)(timeSinceDate / (60.0 * 60.0));
        NSUInteger minutesSinceDate = (NSUInteger)(timeSinceDate / 60.0);
        
        switch(hoursSinceDate) {
            default: return [NSString stringWithFormat:@"%lu hours ago", (unsigned long)hoursSinceDate];
            case 1:
                return @"1 hour ago";
            case 0:
                if (minutesSinceDate > 1) {
                    return [NSString stringWithFormat:@"%lu minutes ago", (unsigned long)minutesSinceDate];
                } else if (minutesSinceDate == 1) {
                    return @"1 minute ago";
                } else {
                    if (timeSinceDate == 1) {
                        return @"1 second ago";
                    } else {
                        return [NSString stringWithFormat:@"%lu seconds ago", (unsigned long)timeSinceDate];
                    }
                }
        }
    } else {
        return [NSString stringWithFormat:@"%@", self.createdAt];
    }
    return nil;
}

+ (NSArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc]initWithDictionary:dictionary]];
    }
    return tweets;
}

@end
