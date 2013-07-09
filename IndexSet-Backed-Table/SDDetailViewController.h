//
//  SDDetailViewController.h
//  IndexSet-Backed-Table
//
//  Created by Sean on 7/8/13.
//  Copyright (c) 2013 Sean Dougherty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
