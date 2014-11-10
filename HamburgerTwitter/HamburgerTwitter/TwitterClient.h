//
//  TwitterClient.h
//  TwitterApp
//
//  Created by Gautam Sewani on 10/30/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager
@property (nonatomic, strong) void (^loginCompletion) (User* user, NSError * error);
+ (TwitterClient*)sharedInstance;
- (void) loginWithCompletetion: (void (^) (User* user, NSError * error))completion;
- (void) openUrl:(NSURL *)url;
- (void) postTweet:(NSString*)tweetText withCompletion:(void(^)(NSError* error)) completion;
- (void) favoriteStatusToggleForTweet:(Tweet*)tweet withCompletion:(void(^)(NSError* error)) completion;
- (void) retweetTweet:(Tweet*)tweet withCompletion:(void(^)(NSError* error)) completion;
@end
