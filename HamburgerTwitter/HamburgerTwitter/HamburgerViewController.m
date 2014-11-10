//
//  HamburgerViewController.m
//  HamburgerTwitter
//
//  Created by Gautam Sewani on 11/8/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "HamburgerViewController.h"
#import "MenuViewController.h"
#import "User.h"

@interface HamburgerViewController ()

@end

@implementation HamburgerViewController {
    BOOL menuShown;
}

+ (HamburgerViewController *)sharedInstance {
    static HamburgerViewController* sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[HamburgerViewController alloc]init];
    }
    return sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    menuShown = false;
    [self.leftView insertSubview:_leftViewController.view belowSubview:self.contentView];
    [self.contentView addSubview:_contentViewController.view];

    UIPanGestureRecognizer *contentPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onContentPan:)];
    [self.contentView addGestureRecognizer:contentPanGestureRecognizer];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    _contentViewController.navigationItem.title = @"Lalal";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onMenuTap {
    if (menuShown) {
        [self showContent];
    } else {
        [self showMenu];
    }
}

- (void) onContentPan:(UIPanGestureRecognizer*) p {
    CGPoint point = [p translationInView:self.view];
    NSLog(@"Translation: %@", NSStringFromCGPoint(point));
    if (p.state == UIGestureRecognizerStateChanged) {
        CGRect frame = self.contentView.frame;
        if (menuShown) {
            frame.origin.x = MIN(300 + [p translationInView:self.view].x, 300);
        } else {
            frame.origin.x = [p translationInView:self.view].x;
        }
        self.contentView.frame = frame;
    } else if (p.state == UIGestureRecognizerStateEnded) {
        if (self.contentView.frame.origin.x > 160) {
            [self showMenu];
        } else {
            [self showContent];
        }
    }
}

- (void) showMenu {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
        CGRect frame = self.contentView.frame;
        frame.origin.x = 300;
        self.contentView.frame = frame;
    } completion:nil];
    menuShown = true;
}

- (void) showContent {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
        CGRect frame = self.contentView.frame;
        frame.origin.x = 0;
        self.contentView.frame = frame;
    } completion:nil];
    menuShown = false;
}


- (void) setLeftViewController:(UIViewController *)leftViewController {
    NSLog(@"Setting left view");
    ((MenuViewController *)leftViewController).hvc = self;
    _leftViewController = [[UINavigationController alloc] initWithRootViewController:leftViewController];
    
}

- (void) setContentViewController:(UIViewController *)contentViewController{
    contentViewController.navigationItem.title = contentViewController.title;
    contentViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(onMenuTap)];
    contentViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Log Out" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout)];
    _contentViewController = [[UINavigationController alloc] initWithRootViewController:contentViewController];

    [self.contentView addSubview:_contentViewController.view];
}

- (void) onLogout {
    [User logout];
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
