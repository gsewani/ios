//
//  SearchResultCell.h
//  Yelp
//
//  Created by Gautam Sewani on 10/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *businessImage;
@property (weak, nonatomic) IBOutlet UILabel *businessName;
@property (weak, nonatomic) IBOutlet UILabel *businessDistance;
@property (weak, nonatomic) IBOutlet UIImageView *businessRatingImage;
@property (weak, nonatomic) IBOutlet UILabel *businessReviewCount;
@property (weak, nonatomic) IBOutlet UILabel *businessAddress;
@property (weak, nonatomic) IBOutlet UILabel *businessCategory;

@end
