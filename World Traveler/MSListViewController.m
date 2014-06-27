//
//  MSViewController.m
//  World Traveler
//
//  Created by Mat Sletten on 6/25/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "MSListViewController.h"
#import "MSFourSquareSessionManager.h"
#import "AFMMRecordResponseSerializer.h"
#import "AFMMRecordResponseSerializationMapper.h"
#import "Venue.h"
#import "Location.h"
#import "MSMapViewController.h"

static NSString *const kMSCLIENTID = @"3VSOUARZJAMSZULCEARWLX5BTYL2U5XOE1ML4FRUTMC5EGLJ";
static NSString *const kMSCLIENTSECRET = @"15C555UQY5XAE2WAHTTFB5WV1SAQRIQYOSU2EU35WLTY2QRH";

//Four Square Client ID above
//Four Square Client Secret above

@interface MSListViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) NSArray *venues;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation MSListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 10.0;
    
    // To start it is necessary to create an instance of TCFourSquareSession manager. Remember it is a singleton so there can only be a maximum of one instance of TCFourSquareSession in our application at a time. Next we need to get the NSManagedObjectContext from Magical Record. Remember from our prior core data lectures that NSManagedObjectContext is responsible for interacting with our entity objects. Now we need a serializer to properly handle the HTTPResponse and register our Entity description to the end point we’ll be accessing. Finally we leverage AFMMRecordResponseSerializer which is a response serializer for AFNetworking. It will serialize an HTTP response object into a list of MMRecord objects
    
    MSFourSquareSessionManager *sessionManager = [MSFourSquareSessionManager sharedClient];
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    AFHTTPResponseSerializer *HTTPResponseSerializer = [AFJSONResponseSerializer serializer];
    AFMMRecordResponseSerializationMapper *mapper =[[AFMMRecordResponseSerializationMapper alloc] init];
    [mapper registerEntityName:@"Venue" forEndpointPathComponent:@"venues/search?"];
    AFMMRecordResponseSerializer *serializer = [AFMMRecordResponseSerializer serializerWithManagedObjectContext:context responseObjectSerializer:HTTPResponseSerializer entityMapper:mapper];
    sessionManager.responseSerializer = serializer;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = sender;
    Venue *venue = self.venues[indexPath.row];
    MSMapViewController *mapVC = segue.destinationViewController;
    mapVC.venue = venue;
}

#pragma mark - IBActions

- (IBAction)refreshBarButtonPressed:(UIBarButtonItem *)sender
{
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    [self.locationManager stopUpdatingLocation];
    [[MSFourSquareSessionManager sharedClient] GET:[NSString stringWithFormat:@"venues/search?ll=%f,%f",location.coordinate.latitude,location.coordinate.longitude] parameters:@{@"client_id" : kMSCLIENTID, @"client_secret" : kMSCLIENTSECRET, @"v" : @"20140416"} success:^(NSURLSessionDataTask *task, id responseObject)
    {
        NSArray *venues = responseObject;
        self.venues = venues;
        [self.tableView reloadData];
   } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.venues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Venue *venue = self.venues[indexPath.row];
    cell.textLabel.text = venue.name;
    cell.detailTextLabel.text = venue.location.address;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"listToMapSegue" sender:indexPath];
}


@end
