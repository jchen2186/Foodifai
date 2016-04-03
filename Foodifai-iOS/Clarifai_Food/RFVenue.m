//
//  RFVenue.m
//  Clarifai_Food
//
//  Created by Ross Freeman on 4/2/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import "RFVenue.h"

@implementation RFVenue

-(id)initWithData:(NSDictionary *)data {
    self = [super init];
    
    if (self) {
        NSDictionary *venueInfo = [data objectForKey:@"venue"];
        self.coordinates = [[NSMutableArray alloc] init];
        
        self.name = [venueInfo objectForKey:@"name"];
        
        NSDictionary *locationInfo = [venueInfo objectForKey:@"location"];
        [self.coordinates addObject:[locationInfo objectForKey:@"lng"]];
        [self.coordinates addObject:[locationInfo objectForKey:@"lat"]];
        self.address = [NSString stringWithFormat:@"%@\n%@, %@ %@", [locationInfo objectForKey:@"address"], [locationInfo objectForKey:@"city"], [locationInfo objectForKey:@"state"], [locationInfo objectForKey:@"postalCode"]];
        
        NSDictionary *hours = [venueInfo objectForKey:@"hours"];
        self.status = [hours objectForKey:@"status"];
    }
    
    return self;
}

@end
