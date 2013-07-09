//
//  SDMasterViewController.h
//  IndexSet-Backed-Table
//
//  Created by Sean on 7/8/13.
//  Copyright (c) 2013 Sean Dougherty. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDDetailViewController;

@interface SDMasterViewController : UITableViewController

@property (strong, nonatomic) SDDetailViewController *detailViewController;

@end
