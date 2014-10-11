//
//  SettingsViewController.m
//  tipcalculator2
//
//  Created by Gautam Sewani on 10/10/14.
//  Copyright (c) 2014 Gautam Sewani. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
- (IBAction)onTap:(id)sender;
- (void)saveTax;
@property (weak, nonatomic) IBOutlet UITextField *taxField;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    int taxPercentage = [defaults integerForKey:@"tax_percentage"];
    self.taxField.text = [NSString stringWithFormat:@"%d", taxPercentage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self saveTax];
}

- (void)saveTax {
    int taxPercentage = [self.taxField.text intValue];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:taxPercentage forKey:@"tax_percentage"];
    [defaults synchronize];
}

@end
