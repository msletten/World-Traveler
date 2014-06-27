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

static NSString *const kMSCLIENTID = @"3VSOUARZJAMSZULCEARWLX5BTYL2U5XOE1ML4FRUTMC5EGLJ";
static NSString *const kMSCLIENTSECRET = @"15C555UQY5XAE2WAHTTFB5WV1SAQRIQYOSU2EU35WLTY2QRH";

//Four Square Client ID above
//Four Square Client Secret above

@interface MSListViewController ()

@end

@implementation MSListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // To start it is necessary to create an instance of TCFourSquareSession manager. Remember it is a singleton so there can only be a maximum of one instance of TCFourSquareSession in our application at a time. Next we need to get the NSManagedObjectContext from Magical Record. Remember from our prior core data lectures that NSManagedObjectContext is responsible for interacting with our entity objects. Now we need a serializer to properly handle the HTTPResponse and register our Entity description to the end point we’ll be accessing. Finally we leverage AFMMRecordResponseSerializer which is a response serializer for AFNetworking. It will serialize an HTTP response object into a list of MMRecord objects
    
    MSFourSquareSessionManager *sessionManager = [MSFourSquareSessionManager sharedClient];
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    AFHTTPResponseSerializer *HTTPResponseSerializer = [AFJSONResponseSerializer serializer];
    AFMMRecordResponseSerializationMapper *mapper =[[AFMMRecordResponseSerializationMapper alloc] init];
    [mapper registerEntityName:@"Venue" forEndpointPathComponent:@"venues/search?"];
    AFMMRecordResponseSerializer *serializer = [AFMMRecordResponseSerializer serializerWithManagedObjectContext:context responseObjectSerializer:HTTPResponseSerializer entityMapper:mapper];
    sessionManager.responseSerializer = serializer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshBarButtonPressed:(UIBarButtonItem *)sender
{
    [[MSFourSquareSessionManager sharedClient] GET:@"venues/search?ll=30.25,-97.75" parameters:@{@"client_id" : kMSCLIENTID, @"client_secret" : kMSCLIENTSECRET, @"v" : @"20140416"} success:^(NSURLSessionDataTask *task, id responseObject)
    {
        NSLog(@"Success: %@", responseObject);
   } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"Error: %@", error);
    }];
}
@end
