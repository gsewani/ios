//
//  MovieCell.h
//  RottenTomatoesAssignment
//
//  Created by Gautam Sewani on 10/18/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *synopsis;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@end
