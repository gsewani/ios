//
//  FilterViewController.h
//  Yelp
//
//  Created by Gautam Sewani on 10/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterCell.h"

@class FilterViewController;

@protocol FilterViewControllerDelegate <NSObject>

- (void) filterViewController:(FilterViewController *)fvc didChangeFilters:(NSDictionary *)filters;

@end
@interface FilterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, FilterCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *filterTable;
@property (weak,nonatomic) id<FilterViewControllerDelegate> delegate;
@end
