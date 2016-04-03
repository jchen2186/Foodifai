//
//  RFVenue.h
//  Clarifai_Food
//
//  Created by Ross Freeman on 4/2/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFVenue : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) double rating;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSMutableArray *coordinates;


-(id)initWithData:(NSDictionary *)data;

@end
