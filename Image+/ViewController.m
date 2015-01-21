//
//  ViewController.m
//  Image+
//
//  Created by Nick Reeder on 1/8/15.
//  Copyright (c) 2015 Nick Reeder. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
<CLImageEditorDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.imageView.image) {
        self.editPhoto.enabled = NO;
        self.actionButton.enabled = NO;
        self.imageView.image = nil;
        
    }
    
   }

#pragma -mark ActivityController


//Remember to add property UIActivityController as a property in .h file
- (IBAction)actionButton:(id)sender {
    UIImage *img = self.imageView.image;
    
    self.activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[img] applicationActivities:nil];
    
    [self presentViewController:self.activityViewController animated:YES completion:nil];
}
    



#pragma -mark Action Options Action Sheet
- (IBAction)editPhoto:(id)sender {
    
   
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        
        UIAlertView *uav = [[UIAlertView alloc] initWithTitle:@"Edit Image" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Edit", @"Revert to Original", @"Discard Image", nil];
        
        [uav show];
 
        
    } else {
    
    UIAlertController *editPhotoOptions = [UIAlertController alertControllerWithTitle:@"Image Options" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *edit = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *edit) {
        
        [self editPicture];
    }];
    
    UIAlertAction *revertToOriginal= [UIAlertAction actionWithTitle:@"Revert to Original" style:UIAlertActionStyleDefault handler:^(UIAlertAction *revertToOriginal) {
        
        [self revertToOriginalPicture];
    }];
    
    UIAlertAction *discard= [UIAlertAction actionWithTitle:@"Discard Image" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *discard) {
        
        [self discardImage];
    }];
    
    UIAlertAction *cancel= [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *discard) {
     
    }];
    
    
    [editPhotoOptions addAction:edit];
    [editPhotoOptions addAction:revertToOriginal];
    [editPhotoOptions addAction:discard];
    [editPhotoOptions addAction:cancel];
    
    [self presentViewController:editPhotoOptions animated:YES completion:NULL];
    }

}

/*-(void)saveImageToLibrary{
    if (self.imageView.image != nil) {
        UIImageWriteToSavedPhotosAlbum (self.imageView.image, self, @selector(thisImage:hasBeenSavedInPhotoAlbumWithError:usingContextInfo:), NULL);
    }
}

-(void)thisImage:(UIImage *)image hasBeenSavedInPhotoAlbumWithError:(NSError *)
error usingContextInfo:(void*)ctxInfo {
    
    
    NSString *message;
    
    if( !error){
        message = @"Saved iamge to Library";
    }else{
        message = @"There was an error saving image to library";
    }
    
    UIAlertController *imageAlert = [UIAlertController alertControllerWithTitle:@"Success" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    [imageAlert addAction:okAction];
    
    [self presentViewController:imageAlert animated:YES completion:nil];
}

-(void)sendEmail{
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
       
        mailComposer.mailComposeDelegate = self;
        [mailComposer setSubject:@"New Image+"];
        
        NSData *attachmentsAsData = UIImagePNGRepresentation(self.imageView.image);
        
        [mailComposer addAttachmentData:attachmentsAsData mimeType:@"image/png" fileName:@"Image+.png"];
        
  	     [self presentViewController:mailComposer animated:YES completion:NULL];
    }

}
*/

-(void)editPicture{
    
    [self presentImageEditorWithImage:self.imageView.image];
}

-(void)revertToOriginalPicture{
    self.imageView.image = self.originalImage;
    
}

-(void)discardImage{
    
    self.imageView.image = nil;
    self.actionButton.enabled = NO;
    self.editPhoto.enabled = NO;
}


#pragma -mark Image Options
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

#pragma -mark UIPicker and Editor methods and functions

- (void)presentImageEditorWithImage:(UIImage*)image
{
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:image];
    editor.delegate = self;
    
    [self presentViewController:editor animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    self.actionButton.enabled = YES;
    self.editPhoto.enabled = YES;
    
    UIImage *chosenImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.originalImage = chosenImage;
    
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:chosenImage];
    editor.delegate = self;
    

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



#pragma -mark didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma -mark Mail Composer

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    NSString *message;
    
    
    [controller dismissViewControllerAnimated:YES completion:NULL];
    
    if (result == MFMailComposeResultSent) {
        message = @"Email Sent";
    } else if (result == MFMailComposeResultCancelled){
        message = @"Send Cancelled";
    } else  if (result == MFMailComposeResultSaved){
        message = @"Message Saved";
    } else if (result == MFMailComposeResultFailed){
        message = @"Message Failed";
    }
    
    UIAlertController *uac = [UIAlertController alertControllerWithTitle:@"Email Status" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    [uac addAction:okAction];
    [self presentViewController:uac animated:YES completion:nil];
}

@end

