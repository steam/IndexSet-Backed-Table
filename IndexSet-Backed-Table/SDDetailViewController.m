//
//  SDDetailViewController.m
//  IndexSet-Backed-Table
//
//  Created by Sean Dougherty on 7/8/13.

#import "SDDetailViewController.h"

@interface SDDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation SDDetailViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self configureView];
}


#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController
	 willHideViewController:(UIViewController *)viewController
		  withBarButtonItem:(UIBarButtonItem *)barButtonItem
	   forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Days", @"Days");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController
	 willShowViewController:(UIViewController *)viewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - Public Mehtods

- (void)configureView
{
	if (self.date && self.dateFormatter)
	{
		self.dateFormatter.dateFormat = @"dd";
	    self.dateLabel.text = [self.dateFormatter stringFromDate:self.date];
		self.dateFormatter.dateFormat = @"EEEE MMMM d, y";
		self.title = [self.dateFormatter stringFromDate:self.date];
	}
}

#pragma mark - Getters / Setters

- (void)setDate:(NSDate *)date
{
    if (_date != date)
	{
        _date = date;
    }
	
    if (self.masterPopoverController != nil)
	{
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

@end
