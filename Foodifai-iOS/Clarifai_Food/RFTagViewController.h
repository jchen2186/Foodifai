//
//  RFTagViewController.h
//  Clarifai_Food
//
//  Created by Ross Freeman on 4/2/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

#import "ClarifaiClient.h"
#import "RFCredentials.h"
#import "RFRestaurantViewController.h"

@interface RFTagViewController : UIViewController

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) ClarifaiClient *client;
@property (strong, nonatomic) NSArray *tags;

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (NSMutableArray *)getPhotoTags;
- (ClarifaiClient *)client;
- (void)recognizeImage:(UIImage *)image;

@end
