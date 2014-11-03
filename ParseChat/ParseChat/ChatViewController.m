//
//  ChatViewController.m
//  ParseChat
//
//  Created by Gautam Sewani on 10/29/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "ChatViewController.h"
#import <Parse/PFObject.h>
#import <Parse/PFQuery.h>
#import "MessageCellTableViewCell.h"

@interface ChatViewController ()
- (IBAction)onSend:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *message;
@property (weak, nonatomic) IBOutlet UITableView *messageTable;
@property (strong, atomic) NSArray *messages;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageTable.dataSource = self;
    self.messageTable.delegate = self;
    UINib *messageCellNib = [UINib nibWithNibName:@"MessageCellTableViewCell" bundle:nil];
    [self.messageTable registerNib:messageCellNib forCellReuseIdentifier:@"MessageCellTableViewCell"];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(onTimer) userInfo:nil repeats:YES];
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

- (IBAction)onSend:(id)sender {
    PFObject *message = [PFObject objectWithClassName:@"Message"];
    message[@"text"] = self.message.text;
    message[@"user"] = [PFUser  currentUser];
    [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"Message sent");
    }];
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCellTableViewCell* cell = [self.messageTable dequeueReusableCellWithIdentifier:@"MessageCellTableViewCell" forIndexPath:indexPath];
    cell.message.text = self.messages[indexPath.row][@"text"];
    return cell;
//    return nil;
}

- (void) fetchMessages {
    PFQuery *query = [PFQuery queryWithClassName:@"Message"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            self.messages = objects;
            [self.messageTable reloadData];
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object[@"text"]);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void) onTimer {
    [self fetchMessages];
    // Add code to be run periodically
}


@end
