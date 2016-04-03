//
//  RFVenueDetailViewController.m
//  Clarifai_Food
//
//  Created by Ross Freeman on 4/3/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import "RFVenueDetailViewController.h"

@interface RFVenueDetailViewController ()

@end

@implementation RFVenueDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _venue.name;
    
    self.uberButton.backgroundColor = [UIColor clearColor];
    
    if (_venue.status != nil) {
        self.statusLabel.text = _venue.status;
    }
    
    else {
        self.statusLabel.text = @"No Status Available";
    }
    
    double x = [_venue.coordinates[1] doubleValue];
    double y = [_venue.coordinates[0] doubleValue];
    
    // Do any additional setup after loading the view.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:x
                                                            longitude:y
                                                                 zoom:16];
    
    _mapView.frame = CGRectZero;
    _mapView.camera = camera;
    
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(x, y);
    marker.title = self.venue.name;
    marker.snippet = self.venue.address;
    marker.map = _mapView;
    
    _mapView.selectedMarker = marker;
    
    BTNLocation *location = [BTNLocation locationWithName:self.venue.name
                                                 latitude:x
                                                longitude:y];
    BTNContext *context = [BTNContext contextWithSubjectLocation:location];
    
    // Prepare the Button for display
    [[BTNDropinButton appearance] setBorderWidth:1];
    [[BTNDropinButton appearance] setBorderColor:[UIColor whiteColor]];
    [[BTNDropinButton appearance] setTextColor:[UIColor whiteColor]];
    [[BTNDropinButton appearance] setCornerRadius:10];
    [[BTNDropinButton appearance] setHighlightedBackgroundColor:[UIColor colorWithRed:180/255.0
                                                                                green:138/255.0
                                                                                 blue:171/255.0
                                                                                alpha:0.25]];
    
    [self.uberButton prepareWithContext:context completion:^(BOOL isDisplayable) {
        if (!isDisplayable) {
            // If a button has no action, it completes as not displayable.
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
