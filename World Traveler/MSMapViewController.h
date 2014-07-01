//
//  MSMapViewController.h
//  World Traveler
//
//  Created by Mat Sletten on 6/25/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"


@interface MSMapViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) Venue *venue;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

- (IBAction)ShowDirectionsBarButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)favoriteButtonPressed:(UIButton *)sender;

@end
