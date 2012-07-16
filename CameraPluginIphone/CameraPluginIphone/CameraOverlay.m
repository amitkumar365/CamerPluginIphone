//
//  CameraOverlay.m
//  CameraPluginIphone
//
//  Created by Letsgomo Labs on 09/07/12.
//  Copyright (c) 2012 mobile@letsgomo.com. All rights reserved.
//

#import "CameraOverlay.h"

@interface CameraOverlay ()

@end

@implementation CameraOverlay
@synthesize pickerController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(IBAction)takepic:(id)sender{
UILabel *scanningLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 50, 120, 30)];
	scanningLabel.backgroundColor = [UIColor clearColor];
	scanningLabel.font = [UIFont fontWithName:@"Courier" size: 18.0];
	scanningLabel.textColor = [UIColor redColor]; 
	scanningLabel.text = @"Loading...";
  UIImage *overlayGraphic = [UIImage imageNamed:@"mask.png"];
		UIImageView *overlayGraphicView = [[UIImageView alloc] initWithImage:overlayGraphic];
		overlayGraphicView.frame = CGRectMake(135, 215, 50, 50);
		[self.view addSubview:overlayGraphicView];
		[overlayGraphicView release];
    UIActivityIndicatorView*  spinner = [[UIActivityIndicatorView alloc] 
                                     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
	spinner.hidesWhenStopped = YES;
  [self.view addSubview:spinner];
[spinner startAnimating];

	[self.view addSubview:scanningLabel];
	
[pickerController takePicture];
//[pickerController dismissModalViewControllerAnimated:true];
[scanningLabel release];
[spinner release];
[pickerController release];
}

-(IBAction)onCancelButtonClicked:(id)sender{
//NSLog(@"onCancelButtonClicked");
[pickerController dismissModalViewControllerAnimated:true];
}
-(IBAction)onAlternateButtonClicked:(id)sender{
//NSLog(@"onAlternateButtonClicked");
if([UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceFront]){
if(pickerController.cameraDevice ==UIImagePickerControllerCameraDeviceFront)
 pickerController.cameraDevice =  UIImagePickerControllerCameraDeviceRear;
  else pickerController.cameraDevice =UIImagePickerControllerCameraDeviceFront;
}
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)dealloc{
//[pickerController release];
[super dealloc];
}
@end
