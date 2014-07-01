//
//  MSFavoriteVenuesViewController.m
//  World Traveler
//
//  Created by Mat Sletten on 7/1/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "MSFavoriteVenuesViewController.h"
#import "MSAppDelegate.h"

@interface MSFavoriteVenuesViewController ()

@end

@implementation MSFavoriteVenuesViewController

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
