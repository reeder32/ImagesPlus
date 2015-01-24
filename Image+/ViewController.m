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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(discardImage) name:UIApplicationDidEnterBackgroundNotification object:nil];

        if (!self.imageView.image) {
        self.editButton.enabled = NO;
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
- (IBAction)editButton:(id)sender {
    
   
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        
        UIAlertView *uav = [[UIAlertView alloc] initWithTitle:@"Edit Image" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Edit", @"Revert to Original", @"Discard Image", nil];
        
        [uav show];
 
        
    } else {
        
        
    UIAlertController *editPhotoOptions = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:@"Image Options"];
    [attributedTitle addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, attributedTitle.length)];
    
    [attributedTitle addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleThick] range:NSMakeRange(0, attributedTitle.length)];
    [attributedTitle addAttribute:NSUnderlineColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, attributedTitle.length)];
    
    [attributedTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24.0] range:NSMakeRange(0, attributedTitle.length)];
    
    [editPhotoOptions setValue:attributedTitle forKey:@"attributedTitle"];
    
        
    
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

/* Unused edit options to be used with action controller. I implemented ActivityController to handle these methods.
 
 -(void)saveImageToLibrary{
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


#pragma -mark Edit Option Methods
-(void)editPicture{
    
    [self presentImageEditorWithImage:self.imageView.image];
}

-(void)revertToOriginalPicture{
    self.imageView.image = self.originalImage;
    
}

-(void)discardImage{
    
    self.imageView.image = nil;
    self.imageLabel.hidden = NO;
    self.arrowImage.hidden = NO;
    self.actionButton.enabled = NO;
    self.editButton.enabled = NO;
}


#pragma -mark Image Options
- (IBAction)showAddImagaes:(id)sender {
    self.imageLabel.hidden = YES;
    self.arrowImage.hidden = YES;

    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        
        UIAlertView *uav = [[UIAlertView alloc] initWithTitle:@"Add Image" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Library", @"Camera", nil];
        
        [uav show];

    } else {
        
    
        
    UIAlertController *addMedia = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:@"Add Image"];
    
    [attributedTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24.0] range:NSMakeRange(0, attributedTitle.length)];
    [attributedTitle addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, attributedTitle.length)];
        
    [attributedTitle addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleThick] range:NSMakeRange(0, attributedTitle.length)];
    [attributedTitle addAttribute:NSUnderlineColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, attributedTitle.length)];
        
    [addMedia setValue:attributedTitle forKey:@"attributedTitle"];
        
    
    UIAlertAction *library = [UIAlertAction actionWithTitle:@"Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *library) {
        [self chooseImageFromLibrary];
    }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *camera) {
        [self takePicture];
    }];
    
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *cancel) {
        self.arrowImage.hidden = NO;
        self.imageLabel.hidden = NO;
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
    picker.allowsEditing = NO;
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
    self.editButton.enabled = YES;
    
    UIImage *chosenImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.originalImage = chosenImage;
    
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:chosenImage];
    editor.delegate = self;
    

    [picker pushViewController:editor animated:YES];
    
        
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    self.editButton.enabled = NO;
    self.actionButton.enabled = NO;
    
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


#pragma -mark Un-used Mail Composer

/* Unused due to implementation of activity controller
 
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
*/

@end

