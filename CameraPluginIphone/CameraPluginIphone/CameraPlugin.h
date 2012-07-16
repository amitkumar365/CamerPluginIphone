#ifdef CORDOVA_FRAMEWORK
#import <CORDOVA/CDVPlugin.h>
#else
#import "CDVPlugin.h"
#endif
//#import "ImageView.h"


// ======================================================================= //

@interface CameraPlugin : CDVPlugin

@property (nonatomic, copy) NSString* callbackId;
-(void)returnImage:(UIImage*)anImage;
-(void)returnFilePath:(NSString*)filepath;


- (void) dealloc;

@end


