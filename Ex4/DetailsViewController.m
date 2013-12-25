//
//  DetailsViewController.m
//  Ex4
//
//  Created by Xurxo Méndez Pérez on 25/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import "DetailsViewController.h"
#import "FailedBankDetails.h"
#import "FailedBankDatabase.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

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
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    FailedBankDetails *details = [[FailedBankDatabase database]
                                  failedBankDetails:self.uniqueId];
    if (details != nil) {
        [self.nameLabel setText:details.name];
        [self.cityLabel setText:details.city];
        [self.stateLabel setText:details.state];
        [self.zipLabel setText:[NSString stringWithFormat:@"%@", details.name]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMMM dd, yyyy"];
        [self.closedLabel setText:[formatter stringFromDate:details.closeDate]];
        [self.updateLabel setText:[formatter stringFromDate:details.updatedDate]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
