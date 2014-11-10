//
//  ProfileMenuCell.m
//  HamburgerTwitter
//
//  Created by Gautam Sewani on 11/8/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "ProfileMenuCell.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"
@implementation ProfileMenuCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor colorWithRed:51 green:51 blue:51 alpha:1];
    User *currentUser = [User getCurrentUser];
    [self.profilePicImage setImageWithURL:[NSURL URLWithString:currentUser.profileImageUrl]];
    self.nameLabel.text = currentUser.name;
    self.titleLabel.text = [NSString stringWithFormat:@"@%@",currentUser.screenname];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
