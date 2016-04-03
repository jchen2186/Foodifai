//
//  RFRestaurantViewController.h
//  Clarifai_Food
//
//  Created by Ross Freeman on 4/2/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AFNetworking/AFNetworking.h>

@import CoreLocation;

#import "ClarifaiClient.h"
#import "RFCredentials.h"
#import "RFVenue.h"
#import "RFVenueDetailViewController.h"

@interface RFRestaurantViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) ClarifaiClient *client;
@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSMutableArray *venues;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) CLLocationManager *locationManager;

-(void)getRestaurants;
-(void)getLocation;

@end
