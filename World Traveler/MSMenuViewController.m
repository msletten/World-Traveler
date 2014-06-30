//
//  MSMenuViewController.m
//  World Traveler
//
//  Created by Mat Sletten on 6/30/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "MSMenuViewController.h"
#import "MSListViewController.h"
#import "MSAppDelegate.h"

@interface MSMenuViewController ()

@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) UINavigationController *listNavigationController;

@end

@implementation MSMenuViewController

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
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    if (!self.viewControllers)
    {
        self.viewControllers = [[NSMutableArray alloc] initWithCapacity:3];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!self.listNavigationController)
    {
        MMDrawerController *drawerController = [self drawControllerFromAppDelegate];
        self.listNavigationController = (UINavigationController *)drawerController.centerViewController;
        [self.viewControllers addObject:self.listNavigationController];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.viewControllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"Home";
    }
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMDrawerController *drawController = [self drawControllerFromAppDelegate];
    [drawController setCenterViewController:self.viewControllers[indexPath.row] withCloseAnimation:YES completion:nil];
}

#pragma mark - DrawController Helper

- (MMDrawerController *)drawControllerFromAppDelegate
{
    MSAppDelegate *appDelegate = (MSAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.drawerController;
}

@end
