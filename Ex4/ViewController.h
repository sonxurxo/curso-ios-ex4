//
//  ViewController.h
//  Ex4
//
//  Created by Xurxo Méndez Pérez on 25/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, retain) NSArray *failedBankInfos;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
