//
//  MSFourSquareSessionManager.m
//  World Traveler
//
//  Created by Mat Sletten on 6/27/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "MSFourSquareSessionManager.h"

static NSString *const MSFourSquareBaseURLString = @"https://api.foursquare.com/v2/";

@implementation MSFourSquareSessionManager

//AFHTTPSessionManager provides many methods for making HTTP requests. AFNetworking recommends subclassing AFHTTPSessionManager for each API we integrate into our application. Since we will be using foursquare we subclass it once. Our subclass needs to return a Singleton so that all requests to the foursquare API will be processed by the same instance of AFHTTPSessionManager.

+ (instancetype)sharedClient
{
    static MSFourSquareSessionManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        _sharedClient = [[MSFourSquareSessionManager alloc] initWithBaseURL:[NSURL URLWithString:MSFourSquareBaseURLString]];
    });
    return _sharedClient;
}

@end
