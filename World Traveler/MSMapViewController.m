//
//  MSMapViewController.m
//  World Traveler
//
//  Created by Mat Sletten on 6/25/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "MSMapViewController.h"
#import "Location.h"
#import "FSCategory.h"
#import "MSDirectionsViewController.h"

@interface MSMapViewController ()

@end

@implementation MSMapViewController

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
    
    self.nameLabel.text = self.venue.name;
    self.addressLabel.text = self.venue.location.address;
    
    float latitude = [self.venue.location.lat floatValue];
    float longitude = [self.venue.location.lng floatValue];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coordinate;
    point.title = self.venue.name;
    point.subtitle = self.venue.categories.name;
    [self.mapView addAnnotation:point];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[MSDirectionsViewController class]])
    {
        MSDirectionsViewController *directionsVC = segue.destinationViewController;
        directionsVC.venue = self.venue;
    }
}

- (IBAction)ShowDirectionsBarButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"mapToDirectionsSegue" sender:nil];
}
//When the user presses favoriteBarButtonItemPressed update the favorite property and then call save using MR_saveOnlySelfAndWait
- (IBAction)favoriteButtonPressed:(UIButton *)sender
{
    self.venue.favorite = [NSNumber numberWithBool:YES];
    [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
}
@end
