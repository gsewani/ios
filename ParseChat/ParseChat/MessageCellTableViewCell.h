//
//  MessageCellTableViewCell.h
//  ParseChat
//
//  Created by Gautam Sewani on 10/29/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *message;
@end
