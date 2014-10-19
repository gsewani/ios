//
//  MoviesViewController.m
//  RottenTomatoesAssignment
//
//  Created by Gautam Sewani on 10/18/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailsViewController.h"
#import "SVProgressHUD.h"

@interface MoviesViewController ()
@property (weak, nonatomic) IBOutlet UILabel *networkErrorView;
@property (weak, nonatomic) IBOutlet UITableView *moviesTable;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkErrorView.hidden = YES;
    self.moviesTable.delegate = self;
    self.moviesTable.dataSource = self;
    self.moviesTable.rowHeight = 100;
    self.title = @"Rotten Tomatoes";

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.moviesTable insertSubview:self.refreshControl atIndex:0];
    
    [self.moviesTable registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    [SVProgressHUD show];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // time-consuming task
        [self fetchMovieData: true];
    });
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *) tableView:(UITableView *) tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    //UITableViewCell* cell = [[UITableViewCell alloc]init];
    NSDictionary *movie = self.movies[indexPath.row];
    cell.title.text = movie[@"title"];
    cell.synopsis.text = movie[@"synopsis"];
    NSString *imageUrl = [movie valueForKeyPath:@"posters.thumbnail"];
    [cell.posterView setImageWithURL:[NSURL URLWithString:imageUrl]];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    MovieDetailsViewController *dvc = [[MovieDetailsViewController alloc] init];
    dvc.movie = self.movies[indexPath.row];
    [self.navigationController pushViewController:dvc animated:true];
}

- (void) fetchMovieData: (BOOL)initialLoad {
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=z9geebeppqz3evdumxjcspc4"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            NSLog(@"Completion handler called");
            if (connectionError != nil) {
                self.networkErrorView.hidden = NO;
                NSLog(@"in error!");
            } else {
                NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                self.movies = responseDictionary[@"movies"];
                [self.moviesTable reloadData];
                NSLog(@"response:%@", responseDictionary);
            }
            if (initialLoad) {
                [SVProgressHUD dismiss];
            } else {
                [self.refreshControl endRefreshing];
            }
        
    }];
}
- (void)onRefresh {
    [self fetchMovieData: false];
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
