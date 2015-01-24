//
//  ViewController.h
//  Image+
//
//  Created by Nick Reeder on 1/8/15.
//  Copyright (c) 2015 Nick Reeder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLImageEditor.h"
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,
MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionButton;
@property (weak, nonatomic) IBOutlet UILabel *imageLabel;



@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;
@property (strong, nonatomic) UIActivityViewController *activityViewController;

@property UIImage *originalImage;


@end

