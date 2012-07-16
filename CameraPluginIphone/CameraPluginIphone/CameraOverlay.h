//
//  CameraOverlay.h
//  CameraPluginIphone
//
//  Created by Letsgomo Labs on 09/07/12.
//  Copyright (c) 2012 mobile@letsgomo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ImageView.h"
@protocol OverlayViewControllerDelegate;
@interface CameraOverlay : UIViewController<UIImagePickerControllerDelegate>{

}
@property (assign) UIImagePickerController *pickerController;

-(IBAction)takepic:(id)sender;
-(IBAction)onCancelButtonClicked:(id)sender;
-(IBAction)onAlternateButtonClicked:(id)sender;

- (void)dealloc;
@end
