//
//  FSCategory.h
//  World Traveler
//
//  Created by Mat Sletten on 6/26/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MSRecord.h"

@class Venue;

@interface FSCategory : MSRecord

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Venue *venue;

@end
