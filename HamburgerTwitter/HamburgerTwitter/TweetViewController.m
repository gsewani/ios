//
//  TweetViewController.m
//  TwitterApp
//
//  Created by Gautam Sewani on 11/1/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "TweetViewController.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "TweetDetailsViewController.h"

@interface TweetViewController ()

@end

@implementation TweetViewController

-(id)init {
    if (self = [super init])  {
        self.isMentions = false;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchTweets:false];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tweetTable insertSubview:self.refreshControl atIndex:0];
    
    self.tweetTable.dataSource = self;
    self.tweetTable.delegate = self;
    [self.tweetTable registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    // Do any additional setup after loading the view from its nib.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [self.tweetTable dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.parentNavigationViewController = self;
    [cell loadTweet:self.tweets[indexPath.row]];
    [cell layoutIfNeeded];
    return cell;
}

- (NSInteger) tableView:(UITableView* )tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    TweetDetailsViewController *tdvc = [[TweetDetailsViewController alloc] initWithTweet:self.tweets[indexPath.row]];
    [self.navigationController pushViewController:tdvc animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) fetchTweets: (BOOL) initialFetch {
    NSString *fetchURL = self.isMentions ?
    @"1.1/statuses/mentions_timeline.json" :
    @"1.1/statuses/home_timeline.json";
    
    [[TwitterClient sharedInstance] GET:fetchURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.tweets = [Tweet tweetsWithArray:responseObject];
        [self.tweetTable reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error fetching tweets");
    }];
    if (!initialFetch) {
        [self.refreshControl endRefreshing];
    }
}

- (void) onRefresh {
    [self fetchTweets:false];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tweetTable reloadData];
}


- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tweetTable reloadData];
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
