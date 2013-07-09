//
//  SDCalendarTableViewController.h
//  IndexSet-Backed-Table
//
//  Created by Sean Dougherty on 7/8/13.

#import <UIKit/UIKit.h>

@class SDDetailViewController;

@interface SDCalendarTableViewController : UITableViewController

@property (strong, nonatomic) SDDetailViewController *detailViewController;

@end
