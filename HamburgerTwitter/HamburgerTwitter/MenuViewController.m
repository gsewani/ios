//
//  MenuViewController.m
//  HamburgerTwitter
//
//  Created by Gautam Sewani on 11/8/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "MenuViewController.h"
#import "ProfileMenuCell.h"
#import "IconTableCell.h"
#import "ProfileViewController.h"
#import "TweetViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuTable.delegate = self;
    self.menuTable.dataSource = self;
    [self.menuTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.menuTable.backgroundColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1];
    [self.menuTable registerNib:[UINib nibWithNibName:@"ProfileMenuCell" bundle:nil] forCellReuseIdentifier:@"ProfileMenuCell"];
    [self.menuTable registerNib:[UINib nibWithNibName:@"IconTableCell" bundle:nil] forCellReuseIdentifier:@"IconTableCell"];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = nil;
    if (indexPath.row == 0) {
        cell = [self.menuTable dequeueReusableCellWithIdentifier:@"ProfileMenuCell"];
        if (!cell) {
            cell = [[ProfileMenuCell alloc]init];
        }
    } else if (indexPath.row ==1) {
        cell = [self.menuTable dequeueReusableCellWithIdentifier:@"IconTableCell"];
        if (!cell) {
            cell = [[IconTableCell alloc]init];
        }
        ((IconTableCell*)cell).iconLabel.text = @"Home";
    } else if (indexPath.row == 2) {
        cell = [self.menuTable dequeueReusableCellWithIdentifier:@"IconTableCell"];
        if (!cell) {
            cell = [[IconTableCell alloc]init];
        }
        ((IconTableCell*)cell).iconLabel.text = @"Mentions";
    }
    cell.backgroundColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1];

    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    UIViewController *cvc = nil;
    if (indexPath.row == 0) {
        cvc = [[ProfileViewController alloc]init];
        cvc.title = @"Me";
        ((ProfileViewController*)cvc).user = [User getCurrentUser];
    } else if (indexPath.row == 1) {
        cvc = [[TweetViewController alloc]init];
        cvc.title = @"Home";
    } else if (indexPath.row == 2) {
        cvc = [[TweetViewController alloc]init];
        cvc.title = @"Mentions";
        ((TweetViewController*)cvc).isMentions = true;
    }
    self.hvc.contentViewController = cvc;
    [self.hvc showContent];
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
