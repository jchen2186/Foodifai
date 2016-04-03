//
//  RFVenueDetailViewController.h
//  Clarifai_Food
//
//  Created by Ross Freeman on 4/3/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <Button/Button.h>

#import "RFVenue.h"

@interface RFVenueDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet BTNDropinButton *uberButton;

@property (strong, nonatomic) RFVenue *venue;

@end
