//
//  MSViewController.h
//  World Traveler
//
//  Created by Mat Sletten on 6/25/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)refreshBarButtonPressed:(UIBarButtonItem *)sender;

@end
