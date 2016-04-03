//
//  RFPhotoSubmissionViewController.h
//  Clarifai_Food
//
//  Created by Ross Freeman on 4/2/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RFRestaurantViewController.h"

@interface RFPhotoSubmissionViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) NSMutableArray *capturedImages;

- (IBAction)submitPhoto:(id)sender;

@end
