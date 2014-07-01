//
//  MSAddVenueViewController.h
//  World Traveler
//
//  Created by Mat Sletten on 7/1/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSAddVenueViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *venueNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *foodTypeTextField;
- (IBAction)saveButtonPressed:(UIButton *)sender;
- (IBAction)menuBarButtonPressed:(UIBarButtonItem *)sender;

@end
