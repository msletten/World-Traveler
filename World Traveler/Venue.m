//
//  Venue.m
//  World Traveler
//
//  Created by Mat Sletten on 6/26/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "Venue.h"
#import "Contact.h"
#import "FSCategory.h"
#import "Location.h"
#import "Menu.h"


@implementation Venue

@dynamic name;
@dynamic id;
@dynamic categories;
@dynamic contact;
@dynamic location;
@dynamic menu;

+ (NSString *)keyPathForResponseObject
{
    return @"response.venues";
}

@end
