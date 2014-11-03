//
//  TweetCell.m
//  TwitterApp
//
//  Created by Gautam Sewani on 11/1/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (void) loadTweet:(Tweet *)tweet {
    self.name.text = tweet.user.name;
    self.handle.text = tweet.user.screenname;
    self.tweetText.text = tweet.text;
    [self.tweeterImage setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    self.timeElapsed.text = [tweet getTimeElapsed];
}

- (NSString *)getTimeElapsedForDate:(NSDate *)date {
    NSTimeInterval timeSinceDate = [[NSDate date] timeIntervalSinceDate:date];
        
    if(timeSinceDate < 24.0 * 60.0 * 60.0) {
        NSUInteger hoursSinceDate = (NSUInteger)(timeSinceDate / (60.0 * 60.0));
        NSUInteger minutesSinceDate = (NSUInteger)(timeSinceDate / 60.0);
        
        switch(hoursSinceDate) {
            default: return [NSString stringWithFormat:@"%lu hours ago", (unsigned long)hoursSinceDate];
            case 1:
                return @"1 hour ago";
            case 0:
                if (minutesSinceDate > 0) {
                    return [NSString stringWithFormat:@"%lu minutes ago", (unsigned long)minutesSinceDate];
                } else {
                    return [NSString stringWithFormat:@"%lu seconds ago", (unsigned long)timeSinceDate];
                }
        }
    } else {
      /* normal NSDateFormatter stuff here */
        return [NSString stringWithFormat:@"%@", date];
    }
    return nil;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
