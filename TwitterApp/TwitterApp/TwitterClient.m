//
//  TwitterClient.m
//  TwitterApp
//
//  Created by Gautam Sewani on 10/30/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kTwitterConsumerKey = @"dAqNuXLxf38cZBbnm53yaX5cY";
NSString * const kTwitterConsumerSecret = @"C8rUgYzYEv3lCoykseHLz7gVNhcAvUlyeODXXOK5u18icrFk9L";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@implementation TwitterClient

+ (TwitterClient*)sharedInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl]consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    
    return instance;
}

- (void) loginWithCompletetion: (void (^) (User* user, NSError * error))completion {
    self.loginCompletion = completion;
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oath"] scope:nil success:^(BDBOAuthToken* requestToken) {
        NSLog(@"Got the request token");
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authURL];
    } failure:^(NSError* error) {
        NSLog(@"Error in getting request token:%@", error);
        completion(nil, error);
        //        NSLog(
    }];

}

- (void) openUrl:(NSURL *)url {
    [[TwitterClient sharedInstance] fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuthToken tokenWithQueryString:url.query] success:^(BDBOAuthToken *accessToken) {
        [[TwitterClient sharedInstance].requestSerializer saveAccessToken:accessToken];
        
        [[TwitterClient sharedInstance] GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"user is here");
            NSLog(@"%@",responseObject);
            User *user = [[User alloc]initWithDictionary:responseObject];
            [User setCurrentUser:user];
            self.loginCompletion(user, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            self.loginCompletion(nil, error);
        }];
        
    } failure:^(NSError *error) {
        self.loginCompletion(nil, error);
    }];

}

- (void) postTweet:(NSString*)tweetText withCompletion:(void(^)(NSError* error)) completion {
    [self POST:@"1.1/statuses/update.json" parameters:@{@"status":tweetText} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        completion(error);
    }];
}

- (void) favoriteStatusToggleForTweet:(Tweet*)tweet withCompletion:(void(^)(NSError* error)) completion {
    NSString *postURL = nil;
    if (tweet.favorited) {
        postURL = @"1.1/favorites/destroy.json";
    } else {
        postURL = @"1.1/favorites/create.json";
    }
    [self POST:postURL parameters:@{@"id":tweet.id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        tweet.favorited = [responseObject[@"favorited"] boolValue];
        tweet.favoriteCount = [responseObject[@"favorite_count"] intValue];
        completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        completion(error);
    }];
}

- (void) retweetTweet:(Tweet*)tweet withCompletion:(void(^)(NSError* error)) completion {
    NSString* urlString = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", tweet.id];
    [self POST:urlString parameters:@{@"id":tweet.id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        tweet.retweeted = [responseObject[@"retweeted"] boolValue];
        tweet.retweetCount = [responseObject[@"retweet_count"] intValue];
        completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        completion(error);
    }];
}
@end
