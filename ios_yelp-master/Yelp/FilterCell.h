//
//  FilterCell.h
//  Yelp
//
//  Created by Gautam Sewani on 10/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterCell;

@protocol FilterCellDelegate <NSObject>
- (void) filterCell:(FilterCell *) cell didUpdateValue:(BOOL) value;
@end

@interface FilterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *categoryName;
@property (weak, nonatomic) IBOutlet UISwitch *categorySwitch;
@property (weak,nonatomic) id<FilterCellDelegate> delegate;
@property (nonatomic, assign) BOOL on;

- (void) setOn:(BOOL)on animated:(BOOL) animated;
- (IBAction)switchValueChanged:(id)sender;
@end
