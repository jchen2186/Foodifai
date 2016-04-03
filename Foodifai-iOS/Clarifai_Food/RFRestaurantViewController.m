//
//  RFRestaurantViewController.m
//  Clarifai_Food
//
//  Created by Ross Freeman on 4/2/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import "RFRestaurantViewController.h"

static NSString *const kApiBaseUrl = @"https://api.foursquare.com/v2/venues/explore";

@interface RFRestaurantViewController ()

@end

@implementation RFRestaurantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    self.client = [self client];
    
    self.tags = [[NSArray alloc] init];
    
    [self recognizeImage:self.image];
    
    self.venues = [[NSMutableArray alloc] init];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Sunset"]];
    
    self.tableView.backgroundView = imageView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getRestaurants {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *tags = [self.tags componentsJoinedByString:@","];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:0];
    params = [@{@"client_id":fourClientId, @"client_secret": fourClientSecret, @"v": @"20160402", @"ll": self.location, @"query": tags} mutableCopy];
    
    [manager GET:kApiBaseUrl parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //NSDictionary *info = responseObject[1];
        
        NSLog(@"%@", operation.request.URL.absoluteString);
        NSDictionary *info2 = [responseObject objectForKey:@"response"];
        NSDictionary *info3 = [info2 objectForKey:@"groups"][0];
        NSArray *info4 = [info3 objectForKey:@"items"];
        
        for (NSDictionary *restData in info4) {
            RFVenue *venue = [[RFVenue alloc] initWithData:restData];
            [self.venues addObject:venue];
        }
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

-(void)getLocation {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (fabs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
        self.location = [NSString stringWithFormat:@"%.6f, %.6f", location.coordinate.latitude, location.coordinate.longitude];
        [self.locationManager stopUpdatingLocation];
        
        [self getRestaurants];
    }
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.venues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"restaurant"];
    
    RFVenue *venue = self.venues[indexPath.row];
    
    cell.textLabel.text = venue.name;
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:180/255.0
                                                      green:138/255.0
                                                       blue:171/255.0
                                                      alpha:0.25];
    cell.selectedBackgroundView =  customColorView;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showDetails" sender:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Clarifai

- (ClarifaiClient *)client {
    if (!_client) {
        _client = [[ClarifaiClient alloc] initWithAppID:clarifaiClientId appSecret:clarifaiClientSecret];
    }
    return _client;
}

- (void)recognizeImage:(UIImage *)image {
    // Scale down the image. This step is optional. However, sending large images over the
    // network is slow and does not significantly improve recognition performance.
    CGSize size = CGSizeMake(320, 320 * image.size.height / image.size.width);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Encode as a JPEG.
    NSData *jpeg = UIImageJPEGRepresentation(scaledImage, 0.9);
    
    // Send the JPEG to Clarifai for standard image tagging.
    [self.client recognizeJpegs:@[jpeg] completion:^(NSArray *results, NSError *error) {
        // Handle the response from Clarifai. This happens asynchronously.
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            ClarifaiResult *result = results.firstObject;
            
            self.tags = [result.tags subarrayWithRange:NSMakeRange(0, 3)];
            
            for (NSString *tag in self.tags) {
                NSLog(@"%@", tag);
            }
        }
        [self getLocation];
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    
    RFVenueDetailViewController *dest = [segue destinationViewController];
    
    RFVenue *venue = self.venues[indexPath.row];
    
    dest.venue = venue;
}


@end
