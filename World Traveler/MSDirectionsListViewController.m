//
//  MSDirectionsListViewController.m
//  World Traveler
//
//  Created by Mat Sletten on 6/27/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "MSDirectionsListViewController.h"

@interface MSDirectionsListViewController ()

@end

@implementation MSDirectionsListViewController

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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
//The number of sections in our TableView should be equal to the number of routes available.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.steps count];
}
//The number of rows in each section should be equal to the number of steps in each route.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MKRoute *route = self.steps[section];
    return [route.steps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    MKRoute *route = self.steps[indexPath.section];
    MKRouteStep *step = route.steps[indexPath.row];
    cell.textLabel.text = step.instructions;
    cell.detailTextLabel.text = step.notice;
    [self loadSnapShots:indexPath];
    
    return cell;
}

//To differentiate between the available routes we will add a header to each section in our tableView. ViewForHeaderInSection requires a UIView object to be returned. Luckily we don't have to worry about setting the frame since the delegate method will take care of positioning our view object for us.
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blueColor];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.text = [NSString stringWithFormat:@"Route %i", section + 1];
    return label;
}

#pragma mark - Map Snapshots Helper
//In order to load the snapshots of our map for our directions we will create a helper method which will accept an NSIndexPath object as a parameter. Using our MKRouteStep obtained from our steps array we can create an MKSnapShotOptions object with the appropriate region and size. With a MKSnapShotOptions object we can create an MKMapSnapshotter to request images of our directions. Since the request occurs asynchronously we update the cells imageView property as the information is returned.
- (void)loadSnapShots:(NSIndexPath *)indexPath
{
    MKRoute *route = self.steps[indexPath.section];
    MKRouteStep *step = route.steps[indexPath.row];
    MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
    options.scale = [UIScreen mainScreen].scale;
    
    MKMapRect rect;
    rect.origin = step.polyline.points[0];
    rect.size = MKMapSizeMake(0.0, 0.0);
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(rect);
    region.span.latitudeDelta = 0.001;
    region.span.longitudeDelta = 0.001;
    options.region = region;
    options.size = CGSizeMake(40.0, 40.0);
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    [snapshotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *error)
    {
        if (error)
        {
            NSLog(@"error %@", error);
        }
        else if (!error)
        {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.imageView.image = snapshot.image;
            [cell setNeedsLayout];
        }
    }];
}




@end
