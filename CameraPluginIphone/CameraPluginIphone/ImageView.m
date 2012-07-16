//
//  ImageView.m
//  CameraPluginIphone
//
//  Created by Letsgomo Labs on 06/07/12.
//  Copyright (c) 2012 mobile@letsgomo.com. All rights reserved.
//

#import "ImageView.h"

@interface ImageView ()

@end

@implementation ImageView
@synthesize previewImage,cplugin,scanningLabel,overlayGraphic,overlayGraphicView;
@synthesize overlayViewController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  //  NSLog(@"inside viewDidLoad");
    self.view.hidden=YES;
  scanningLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 50, 120, 30)];
	scanningLabel.backgroundColor = [UIColor clearColor];
	scanningLabel.font = [UIFont fontWithName:@"Courier" size: 18.0];
	scanningLabel.textColor = [UIColor redColor]; 
	scanningLabel.text = @"Loading...";
  overlayGraphic = [UIImage imageNamed:@"mask.png"];
  overlayGraphicView = [[UIImageView alloc] initWithImage:overlayGraphic];
  overlayGraphicView.frame = CGRectMake(135, 215, 50, 50);
 
  /*  self.overlayViewController =
        [[CameraOverlay alloc] initWithNibName:@"CameraOverlay" bundle:nil];*/
       // self.overlayViewController.delegate=self;
   // self.overlayViewController =[[[overlayViewController alloc] initWithNibName:@"CameraOverlay" bundle:nil] autorelease];
     
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
//NSLog(@"inside viewDidUnload");
  [self setPreviewImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{ 
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)closeView:(id)sender{
[self.view removeFromSuperview];
}
-(IBAction)cameraAction:(id)sender{
    [self initializeCamera];
    [self presentModalViewController:self.overlayViewController.pickerController animated:YES];
}
-(IBAction)onUseButtonClicked:(id)sender{
//NSLog(@"onUseButtonClicked");
[self.view addSubview:scanningLabel];
[self.view addSubview:overlayGraphicView];
		
    UIActivityIndicatorView*  spinner = [[UIActivityIndicatorView alloc] 
                                     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
	spinner.hidesWhenStopped = YES;
  [self.view addSubview:spinner];
[spinner startAnimating];

	
[self.cplugin returnImage:self.previewImage.image];
[self.view removeFromSuperview];
 
  [spinner release];
}
-(void)initializeCamera{
self.overlayViewController =[[CameraOverlay alloc] initWithNibName:@"CameraOverlay" bundle:nil];
[self.overlayViewController.view setFrame:CGRectMake(0, 426, 320, 54)];
    self.overlayViewController.pickerController = [[UIImagePickerController alloc] init];
    self.overlayViewController.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.overlayViewController.pickerController.cameraDevice =UIImagePickerControllerCameraDeviceRear;
    self.overlayViewController.pickerController.allowsEditing = NO;
    self.overlayViewController.pickerController.showsCameraControls = NO;
    self.overlayViewController.pickerController.navigationBarHidden = YES;
    self.overlayViewController.pickerController.wantsFullScreenLayout = YES;
    /*self.overlayViewController.pickerController.cameraViewTransform = CGAffineTransformScale(self.overlayViewController.pickerController.cameraViewTransform, 
        CAMERA_TRANSFORM_X, CAMERA_TRANSFORM_Y);*/
    self.overlayViewController.pickerController.delegate = self;
    self.overlayViewController.pickerController.cameraOverlayView = overlayViewController.view;


}

- (void)dealloc {
  [cplugin release];
  [scanningLabel release];
  [overlayGraphicView release];
  [overlayViewController release];
  [previewImage release];
  [super dealloc];
}
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info{
//NSLog(@"ImageView delegate didFinishPickingMediaWithInfo");

self.view.hidden=NO;
UIImage* image = nil;
image = [info objectForKey:UIImagePickerControllerOriginalImage];
 image = [self imageCorrectedForCaptureOrientation:image];
[self.overlayViewController.pickerController dismissModalViewControllerAnimated:YES];
[self.previewImage setImage:image];
}
-(void)openCamera{
//NSLog(@"inside openCamera");
[self initializeCamera];
[self presentModalViewController:self.overlayViewController.pickerController animated:YES];

}
- (UIImage*) imageCorrectedForCaptureOrientation:(UIImage*)anImage
{   
   float rotation_radians = 0;
   bool perpendicular = false;

   switch ([anImage imageOrientation]) {
    case UIImageOrientationUp:
      rotation_radians = 0.0;
      break;
    case UIImageOrientationDown:   
      rotation_radians = M_PI; //don't be scared of radians, if you're reading this, you're good at math
      break;
    case UIImageOrientationRight:
      rotation_radians = M_PI_2;
      perpendicular = true;
      break;
    case UIImageOrientationLeft:
      rotation_radians = -M_PI_2;
      perpendicular = true;
      break;
    default:
      break;
   }
   
   UIGraphicsBeginImageContext(CGSizeMake(anImage.size.width, anImage.size.height));
   CGContextRef context = UIGraphicsGetCurrentContext();
   
   //Rotate around the center point
   CGContextTranslateCTM(context, anImage.size.width/2, anImage.size.height/2);
   CGContextRotateCTM(context, rotation_radians);
   
   CGContextScaleCTM(context, 1.0, -1.0);
   float width = perpendicular ? anImage.size.height : anImage.size.width;
   float height = perpendicular ? anImage.size.width : anImage.size.height;
   CGContextDrawImage(context, CGRectMake(-width / 2, -height / 2, width, height), [anImage CGImage]);
   
   // Move the origin back since the rotation might've change it (if its 90 degrees)
   if (perpendicular) {
     CGContextTranslateCTM(context, -anImage.size.height/2, -anImage.size.width/2);
   }
   
   UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return newImage;
}
@end

