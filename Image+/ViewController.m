//
//  ViewController.m
//  Image+
//
//  Created by Nick Reeder on 1/8/15.
//  Copyright (c) 2015 Nick Reeder. All rights reserved.
//

#import "ViewController.h"
#import "CLImageEditor.h"

@interface ViewController ()
<CLImageEditorDelegate>

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (IBAction)showActions:(id)sender {
    
}

- (IBAction)showAddImagaes:(id)sender {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        
        UIAlertView *uav = [[UIAlertView alloc] initWithTitle:@"Add Image" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Library", @"Camera", nil];
        
        [uav show];
        
    } else {
    
    UIAlertController *addMedia = [UIAlertController alertControllerWithTitle:@"Add Image" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *library = [UIAlertAction actionWithTitle:@"Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *library) {
        [self chooseImageFromLibrary];
    }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *camera) {
        [self takePicture];
    }];
    
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *cancel) {
        NSLog(@"Cancel Button Pressed");
    }];
    
    
    [addMedia addAction:library];
    [addMedia addAction:camera];
    [addMedia addAction:cancel];
    
    [self presentViewController:addMedia animated:YES completion:NULL];
    }
    
}

-(void)chooseImageFromLibrary{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

-(void)takePicture{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    [self presentViewController:picker animated:YES completion:NULL];
        
    } else {
        
        UIAlertController *noCamera = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"Must have a camera." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        }];
        
        [noCamera addAction:action];
         [self presentViewController:noCamera animated:YES completion:nil];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *chosenImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:chosenImage];
    editor.delegate = self;
    
    self.imageView.image = chosenImage;
    
    
    [picker pushViewController:editor animated:YES];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    _imageView.image = image;
    [editor dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
