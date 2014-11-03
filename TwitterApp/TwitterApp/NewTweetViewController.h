//
//  NewTweetViewController.h
//  TwitterApp
//
//  Created by Gautam Sewani on 11/2/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NewTweetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UIImageView *tweeterImage;
@property (strong, nonatomic) NSString* initialText;
@end
