//
//  MSFourSquareSessionManager.h
//  World Traveler
//
//  Created by Mat Sletten on 6/27/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface MSFourSquareSessionManager : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
