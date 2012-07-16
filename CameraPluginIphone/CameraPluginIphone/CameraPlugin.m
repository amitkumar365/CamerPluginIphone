/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import "CameraPlugin.h"
#import "Cordova/NSData+Base64.h"
#import "Cordova/NSDictionary+Extensions.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "ImageView.h"
#import "Cordova/CDVViewController.h"
#import "ImageView.h"
@interface CameraPlugin ()

@end

@implementation CameraPlugin


@synthesize callbackId;
/*  takePicture arguments:
 * INDEX   ARGUMENT
 *  0       callbackId
 *  1       quality
 *  2       destination type
 *  3       source type
 *  4       targetWidth
 *  5       targetHeight
 *  6       encodingType
 *  7       mediaType
 *  8       allowsEdit
 *  9       correctOrientation
 *  10      saveToPhotoAlbum
 */
- (void) takepic:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
// NSLog(@"inside takePicture");

self.callbackId = [arguments pop];
 ImageView* imageView = [[ ImageView alloc ] init];
imageView.cplugin=self;
imageView.view.hidden =YES;
[self.webView addSubview:imageView.view];
double delayInSeconds = 0.1;
dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
   [imageView openCamera];
});

}

-(void)returnImage:(UIImage*)anImage{
//NSLog(@"CameraPlugin inside return image");
  NSData* data = nil;
  data = UIImageJPEGRepresentation(anImage,100/ 100.0f);

  NSString* docsPath = [NSTemporaryDirectory() stringByStandardizingPath];
            NSError* err = nil;
            NSFileManager* fileMgr = [[NSFileManager alloc] init]; //recommended by apple (vs [NSFileManager defaultManager]) to be theadsafe
            
            // generate unique file name
            NSString* filePath;
int i = 1;
            do 
            {
                filePath = [NSString stringWithFormat:@"%@/photo_%03d.%@", docsPath, i++,@"jpg"];
            } 
            while ([fileMgr fileExistsAtPath: filePath]);
  
            [data writeToFile: filePath options: NSAtomicWrite error: &err];
            [self returnFilePath:filePath];
            // save file
    
    
           
}
-(void)returnFilePath:(NSString*)filepath{
 NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
     [result setObject:filepath forKey:@"data"];
      CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
     [self writeJavascript: [pluginResult toSuccessCallbackString:self.callbackId]];
     [result release];
}


- (void) dealloc
{
	[super dealloc];
}

@end


