//
//  FilterCell.m
//  Yelp
//
//  Created by Gautam Sewani on 10/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FilterCell.h"

@implementation FilterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setOn:(BOOL)on {
    [self setOn:on animated:false];
}

- (void) setOn:(BOOL)on animated:(BOOL)animated {
    _on = on;
    [self.categorySwitch setOn:on animated:animated];
}
- (IBAction)switchValueChanged:(id)sender {
    [self.delegate filterCell:self  didUpdateValue:self.categorySwitch.on];
}
@end
