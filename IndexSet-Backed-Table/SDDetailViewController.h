//
//  SDDetailViewController.h
//  IndexSet-Backed-Table
//
//  Created by Sean Dougherty on 7/8/13.

#import <UIKit/UIKit.h>

@interface SDDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

// weakly held because the Calendar Table View holds onto it
@property (nonatomic, weak) NSDateFormatter *dateFormatter;


- (void)configureView;

@end
