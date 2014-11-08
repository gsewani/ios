//
//  CanvasViewController.h
//  Week4Lab
//
//  Created by Gautam Sewani on 11/6/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CanvasViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *smiley1;
@property (weak, nonatomic) IBOutlet UIImageView *smiley2;
@property (weak, nonatomic) IBOutlet UIImageView *smiley3;
@property (weak, nonatomic) IBOutlet UIImageView *smiley4;
@property (weak, nonatomic) IBOutlet UIImageView *smiley5;
@property (weak, nonatomic) IBOutlet UIImageView *smiley6;
- (void)onCustomPan:(UIPanGestureRecognizer *)panGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIView *trayView;
@property (atomic, strong) UIImageView* currentImage;
@end
