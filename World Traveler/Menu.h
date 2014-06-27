//
//  Menu.h
//  World Traveler
//
//  Created by Mat Sletten on 6/26/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MSRecord.h"

@interface Menu : MSRecord

@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSManagedObject *venue;

@end
