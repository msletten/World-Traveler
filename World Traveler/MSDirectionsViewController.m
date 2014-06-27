//
//  MSDirectionsViewController.m
//  World Traveler
//
//  Created by Mat Sletten on 6/27/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "MSDirectionsViewController.h"

@interface MSDirectionsViewController ()

@end

@implementation MSDirectionsViewController

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
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self. locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)listDirectionsBarButtonPressed:(UIBarButtonItem *)sender
{
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    [manager stopUpdatingLocation];
    self.directionsMap.showsUserLocation = YES;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 3000, 3000);
    [self.directionsMap setRegion:[self.directionsMap regionThatFits:region] animated:YES];
    
    float latitude = [self.venue.location.lat floatValue];
    float longitude = [self.venue.location.lng floatValue];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude) addressDictionary:nil];
    MKMapItem *destinationMapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    
    [self getDirections:destinationMapItem];
}

#pragma mark - Directions Helper
//With a MKMapItem we can set the longitude and latitude of the desired destination. In this case we'll be using our venue as the final destination relative to our current location. The MKMapItem will be used as a parameter for our MKDirectionsRequestUsing a MKDirections object initialized with a MKDirectionsRequest object Apple will provide us with turn by turn directions between our two locations. A MKDirectionsRequest can be adjusted to return multiple routes between locations.

- (void)getDirections:(MKMapItem *)destination
{
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = [MKMapItem mapItemForCurrentLocation];
    request.destination = destination;
    request.requestsAlternateRoutes = YES;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error)
    {
        if (error)
        {
            //handle error
            NSLog(@"%@", error);
        }
        else
        {
            //do something with directions here
            [self showRoute:response];
        }
    }];
}

#pragma mark - Route Helper
//Next we'll create a helper method which will allow us to manage the response from the MKDirectionsRequest. Remember to set the property self.steps equal to our response. Our response contains an array of routes. Each route contains a series of steps and the steps have text instructions.

- (void)showRoute:(MKDirectionsResponse *)response
{
    self.steps = response.routes;
    for (MKRoute *route in self.steps)
    {
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"step instructions %@", step.instructions);
        }
    }
}



@end
