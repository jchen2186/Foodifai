//
//  RFTagViewController.m
//  Clarifai_Food
//
//  Created by Ross Freeman on 4/2/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import "RFTagViewController.h"

@interface RFTagViewController ()

@end

@implementation RFTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.client = [self client];
    
    self.tags = [[NSArray alloc] init];
    
    [self recognizeImage:self.image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)getPhotoTags {
    NSMutableArray *tags = [[NSMutableArray alloc] init];
    
    
    return tags;
}

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
            self.textView.text = @"Sorry, there was an error recognizing the image.";
        } else {
            ClarifaiResult *result = results.firstObject;
            self.textView.text = [NSString stringWithFormat:@"Tags:\n%@", [result.tags componentsJoinedByString:@", "]];
            
            self.tags = [result.tags subarrayWithRange:NSMakeRange(0, 3)];
            
            for (NSString *tag in self.tags) {
                NSLog(@"%@", tag);
            }
        }
    }];
}


#pragma mark - Navigation

//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    RFRestaurantViewController *dest = [segue destinationViewController];
//    dest.keywords = self.tags;
//}


@end
