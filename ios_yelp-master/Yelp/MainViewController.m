//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "SearchResultCell.h"
#import "UIImageView+AFNetworking.h"
#import "FilterViewController.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *resultsTable;
@property (nonatomic, strong) NSArray *businesses;
@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSString* searchText;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    }
    self.searchText = @"Restaurants";
    return self;
}


- (void) loadSearchResultsWithTerm: (NSString *) term params: (NSDictionary *)params {
    [self.client searchWithTerm:term params:params success:^(AFHTTPRequestOperation *operation, id response) {
        self.businesses = response[@"businesses"];
        [self.resultsTable reloadData];
        //NSLog(@"response: %@", response[@"businesses"][0]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.businesses.count;
}

- (UITableViewCell *) tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultCell* cell = [self.resultsTable dequeueReusableCellWithIdentifier:@"SearchResultCell"];
    NSDictionary *business = self.businesses[indexPath.row];
    cell.businessName.text = [NSString stringWithFormat: @"%d. %@", (int)indexPath.row + 1, business[@"name"]];
    float distance = [business[@"distance"] floatValue];
    distance /= 1600;
    cell.businessDistance.text = [NSString stringWithFormat:@"%0.2f mi", distance];
    [cell.businessImage setImageWithURL:[NSURL URLWithString:business[@"image_url"]]];
    [cell.businessRatingImage setImageWithURL:[NSURL URLWithString:business[@"rating_img_url"]]];
    cell.businessReviewCount.text = [NSString stringWithFormat:@"%@ reviews", business[@"review_count"]];
    NSArray *streetAddress = [business valueForKeyPath: @"location.display_address"];
    if (streetAddress) {
        cell.businessAddress.text = [NSString stringWithFormat:@"%@, %@",streetAddress[0], streetAddress[1]];
    }
    //    cell.businessAddress = NSString stringWithFormat:@"%@, %@", business[@]
    
    NSArray *categories = business[@"categories"];
    cell.businessCategory.text = [NSString stringWithFormat:@"%@", categories[0][0]];
    [cell layoutIfNeeded];
    return cell;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.resultsTable reloadData];
}


- (void) viewWillDisappear:(BOOL)animated {
    [self.resultsTable reloadData];
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton)];
    self.navigationItem.leftBarButtonItem = leftButton;

    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-5.0, 0.0, 320.0, 44.0)];
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    
    // Do any additional setup after loading the view from its nib.
    self.resultsTable.dataSource = self;
    self.resultsTable.delegate = self;
    
    [self.resultsTable registerNib:[UINib nibWithNibName:@"SearchResultCell" bundle:nil]forCellReuseIdentifier:@"SearchResultCell"];
    self.resultsTable.rowHeight = UITableViewAutomaticDimension;
    [self loadSearchResultsWithTerm:self.searchText params:nil];
    [self.resultsTable reloadData];
}

- (void) filterViewController: (FilterViewController *) fvc didChangeFilters:(NSDictionary *)filters {
    NSLog(@"filter changes:%@", filters);
    [self loadSearchResultsWithTerm:self.searchText params:filters];
}

- (void) onFilterButton {
    FilterViewController *fvc = [[FilterViewController alloc] init];
    fvc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:fvc];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.searchText = searchBar.text;
    [self loadSearchResultsWithTerm:searchBar.text params:nil];
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
