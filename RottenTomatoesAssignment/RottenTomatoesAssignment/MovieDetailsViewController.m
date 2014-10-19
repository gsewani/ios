//
//  MovieDetailsViewController.m
//  RottenTomatoesAssignment
//
//  Created by Gautam Sewani on 10/19/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"

@interface MovieDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *synopsis;
@property (weak, nonatomic) IBOutlet UIScrollView *movieScrollView;
@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *imageUrlString = [self.movie valueForKeyPath:@"posters.original"];
    imageUrlString = [imageUrlString stringByReplacingOccurrencesOfString:@"tmb" withString:@"org"];
    NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:imageUrl];
    [SVProgressHUD show];
    [self.posterImage setImageWithURLRequest:imageRequest placeholderImage:nil  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [SVProgressHUD dismiss];
        self.posterImage.image = image;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        [SVProgressHUD dismiss];
    } ];
    self.movieTitle.text = self.movie[@"title"];
    self.synopsis.text = self.movie[@"synopsis"];
    self.movieScrollView.contentSize = CGSizeMake(320, 1000);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
