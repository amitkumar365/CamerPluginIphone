//
//  ImageView.h
//  CameraPluginIphone
//
//  Created by Letsgomo Labs on 06/07/12.
//  Copyright (c) 2012 mobile@letsgomo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraOverlay.h"
#import "CameraPlugin.h"
#define CAMERA_TRANSFORM_X 1
#define CAMERA_TRANSFORM_Y 1.24299 
@interface ImageView : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
}
-(void)initializeCamera;
-(void)openCamera;
-(IBAction)closeView:(id)sender;
-(IBAction)cameraAction:(id)sender;
-(IBAction)onUseButtonClicked:(id)sender;
@property(assign) UILabel *scanningLabel;
@property(assign) UIImage *overlayGraphic;
@property(assign) UIImageView *overlayGraphicView;
@property (assign) CameraPlugin *cplugin;
@property (assign, nonatomic) IBOutlet UIImageView *previewImage;
@property(nonatomic,assign) CameraOverlay *overlayViewController;
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info;
- (UIImage*)imageCorrectedForCaptureOrientation:(UIImage*)anImage;
- (void)dealloc;
@end

