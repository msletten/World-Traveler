//
//  MSAddVenueViewController.m
//  World Traveler
//
//  Created by Mat Sletten on 7/1/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "MSAddVenueViewController.h"
#import "MSAppDelegate.h"
#import "Venue.h"
#import "Contact.h"
#import "FSCategory.h"

@interface MSAddVenueViewController ()

@end

@implementation MSAddVenueViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonPressed:(UIButton *)sender
{
    if ([self.venueNameTextField.text isEqualToString:@""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Blank Field" message:@"Please enter a name!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
        Venue *venue = [Venue MR_createEntity];
        venue.name = self.venueNameTextField.text;
        Contact *contact = [Contact MR_createEntity];
        contact.phone = self.phoneNumberTextField.text;
        venue.contact = contact;
        FSCategory *category = [FSCategory MR_createEntity];
        category.name = self.foodTypeTextField.text;
        venue.categories = category;
        venue.favorite = [NSNumber numberWithBool:YES];
        [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
    }
}

- (IBAction)menuBarButtonPressed:(UIBarButtonItem *)sender
{
    [[self drawControlerFromAppDelegate] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - DrawController Helper

- (MMDrawerController *) drawControlerFromAppDelegate
{
    MSAppDelegate *appDelegate = (MSAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.drawerController;
}
@end
