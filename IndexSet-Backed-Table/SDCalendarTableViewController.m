//
//  SDCalendarTableViewController.m
//  IndexSet-Backed-Table
//
//  Created by Sean Dougherty on 7/8/13.

#import "SDCalendarTableViewController.h"
#import "SDDetailViewController.h"

#define kNumberOfMonths 360
#define kDayDateFormat @"EEE MMM d"
#define kMonthDateFormat @"MMMM y"

@interface SDCalendarTableViewController ()
@property(nonatomic, strong) NSIndexSet *days;
@property(nonatomic, strong) NSDate *beginningOfThisMonth;
@property(nonatomic, strong) NSDateFormatter *formatter;
@property(nonatomic, strong) NSDateFormatter *detailFormatter;
@property(nonatomic, strong) NSDateComponents *components;
@property(nonatomic, strong) NSDateComponents *components2;
@end

@implementation SDCalendarTableViewController

- (void)awakeFromNib
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
	{
	    self.clearsSelectionOnViewWillAppear = NO;
	    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	}
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.title = NSLocalizedString(@"30 Years of Days", @"30 Years of Days");
			
	// date formatter i.e. "Mon Jul 08, 2013"
	self.formatter = [[NSDateFormatter alloc] init];
	self.formatter.timeZone = [NSTimeZone localTimeZone];
	self.formatter.dateFormat = @"EEE MMM dd, y";
	
	// use a single date formatter for details to save on overhead, date formatters are expensive
	self.detailFormatter = [[NSDateFormatter alloc] init];
	self.detailFormatter.timeZone = [NSTimeZone localTimeZone];

	// date components for day incrementing
	self.components = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
	self.components.day = 1;
	
	// beginningOfThisMonth, the only date created at launch (dates are created as needed)	
	self.beginningOfThisMonth = [[NSCalendar currentCalendar] dateFromComponents:self.components];
	
	// reset the date components
	self.components = [[NSDateComponents alloc] init];
	
	self.detailViewController = (SDDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kNumberOfMonths;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
	return [self numberOfDaysInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
	self.formatter.dateFormat = kMonthDateFormat;
	return [self.formatter stringFromDate:[self dateForIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	self.formatter.dateFormat = kDayDateFormat;
	cell.textLabel.text = [self.formatter stringFromDate:[self dateForIndexPath:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
	{
        self.detailViewController.date = [self dateForIndexPath:indexPath];
		self.detailViewController.dateFormatter = self.detailFormatter;
		[self.detailViewController configureView];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
	{
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [[segue destinationViewController] setDate:[self dateForIndexPath:indexPath]];
		[[segue destinationViewController] setDateFormatter:self.detailFormatter];
		[[segue destinationViewController] configureView];
    }
}


#pragma mark - Private Methods

- (NSDate*)dateForIndexPath:(NSIndexPath*)indexPath
{
	self.components.month = indexPath.section;
	self.components.day = indexPath.row;
	return [[NSCalendar currentCalendar] dateByAddingComponents:self.components toDate:self.beginningOfThisMonth options:0];
}

- (NSUInteger)numberOfDaysInSection:(NSUInteger)section
{
	NSDate *date = [self dateForIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
	NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
	return range.length;
}

#pragma mark - Getters / Setters

- (NSIndexSet*)days
{
    if (_days == nil)
	{
		NSMutableIndexSet *days = [NSMutableIndexSet indexSet];
		
		// 30 years of days
		NSUInteger indexCounter = 0;
		for (NSUInteger i = 0; i < kNumberOfMonths; i++)
		{
			NSUInteger daysInMonth = [self numberOfDaysInSection:i];
			[days addIndexesInRange:NSMakeRange(indexCounter, daysInMonth)];
			indexCounter += daysInMonth;
		}
		
		_days = [days copy];
	}
	
	return _days;
}


@end
