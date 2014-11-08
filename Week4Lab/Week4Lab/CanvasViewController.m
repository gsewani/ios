//
//  CanvasViewController.m
//  Week4Lab
//
//  Created by Gautam Sewani on 11/6/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "CanvasViewController.h"

@interface CanvasViewController ()

@end

@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.smiley1.image = [UIImage imageNamed:@"happy.png"];
    self.smiley2.image = [UIImage imageNamed:@"excited.png"];
    self.smiley3.image = [UIImage imageNamed:@"dead.png"];
    self.smiley4.image = [UIImage imageNamed:@"tongue.png"];
    self.smiley5.image = [UIImage imageNamed:@"wink.png"];
    self.smiley6.image = [UIImage imageNamed:@"sad.png"];

    // The onCustomPan: method will be defined in Step 3 below.
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onCustomPan:)];
    
    // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
    [self.trayView addGestureRecognizer:panGestureRecognizer];
    
    [self addGestureRecognizerForImageView:self.smiley1];
    [self addGestureRecognizerForImageView:self.smiley2];
    [self addGestureRecognizerForImageView:self.smiley3];
    [self addGestureRecognizerForImageView:self.smiley4];
    [self addGestureRecognizerForImageView:self.smiley5];
    [self addGestureRecognizerForImageView:self.smiley6];

    UIPanGestureRecognizer *imagePanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onImagePan:)];
    [self.smiley1 addGestureRecognizer:imagePanGestureRecognizer];
    [self.smiley2 addGestureRecognizer:imagePanGestureRecognizer];
    [self.smiley3 addGestureRecognizer:imagePanGestureRecognizer];
    [self.smiley4 addGestureRecognizer:imagePanGestureRecognizer];
    [self.smiley5 addGestureRecognizer:imagePanGestureRecognizer];
    [self.smiley6 addGestureRecognizer:imagePanGestureRecognizer];

    // Do any additional setup after loading the view from its nib.
}

- (void) addGestureRecognizerForImageView:(UIImageView *)imageView {
    UIPanGestureRecognizer *imagePanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onImagePan:)];
    [imageView addGestureRecognizer:imagePanGestureRecognizer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onImagePan:(UIPanGestureRecognizer *)p {
    if (p.state == UIGestureRecognizerStateBegan) {
        UIImageView* vv = (UIImageView*)p.view;
        UIImageView *newImage = [[UIImageView alloc] initWithFrame:vv.frame];
        newImage.image = vv.image;
        newImage.transform = CGAffineTransformMakeScale(1.4,1.4);
        [self.view addSubview:newImage];
        self.currentImage = newImage;
    } else if (p.state == UIGestureRecognizerStateChanged) {
        self.currentImage.center = [p locationInView:self.view];
    } else if (p.state == UIGestureRecognizerStateEnded) {
        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onSmileyPan:)];
        self.currentImage.userInteractionEnabled = YES;
        [self.currentImage addGestureRecognizer:panGR];
        self.currentImage.transform = CGAffineTransformMakeScale(1.2,1.2);
        
        UIPinchGestureRecognizer *pinchGR = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(onSmileyPinch:)];
        [self.currentImage addGestureRecognizer:pinchGR];

    }
}

- (void)onSmileyPan:(UIPanGestureRecognizer *)p {
    if (p.state == UIGestureRecognizerStateBegan) {
        p.view.transform = CGAffineTransformMakeScale(1.4, 1.4);
    } else if (p.state == UIGestureRecognizerStateChanged) {
        p.view.center = [p locationInView:self.view];
    } else if (p.state == UIGestureRecognizerStateEnded) {
        p.view.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }
}

- (void)onSmileyPinch:(UIPinchGestureRecognizer *)p {
    if (p.state == UIGestureRecognizerStateChanged) {
        p.view.transform = CGAffineTransformMakeScale(p.scale, p.scale);
    }
}

- (void)onCustomPan:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint point = [panGestureRecognizer locationInView:self.view];
    CGPoint velocity = [panGestureRecognizer velocityInView:self.trayView];
    CGRect trayFrame = self.trayView.frame;

    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Gesture began at: %@, %@", NSStringFromCGPoint(point), NSStringFromCGPoint(velocity));
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        NSLog(@"Gesture changed: %@, %@", NSStringFromCGPoint(point), NSStringFromCGPoint(velocity));
        if (velocity.y < 0) {
            trayFrame.origin.y = MAX(point.y, 394);
        } else {
            trayFrame.origin.y = MIN(point.y, 540);
        }
        self.trayView.frame = trayFrame;
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self animateTop:(velocity.y < 0)];
        NSLog(@"Gesture ended: %@, %@", NSStringFromCGPoint(point), NSStringFromCGPoint(point));
    }
}

- (void)animateTop:(BOOL)top {
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:0 animations:^{
        CGRect frame = self.trayView.frame;
        frame.origin.y = top ? 394 : 540;
        self.trayView.frame = frame;
    } completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
