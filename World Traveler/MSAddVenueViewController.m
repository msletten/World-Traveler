//
//  MSAddVenueViewController.m
//  World Traveler
//
//  Created by Mat Sletten on 7/1/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "MSAddVenueViewController.h"
#import "MSAppDelegate.h"
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

- (IBAction)saveButtonPressed:(UIButton *)sender {
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
