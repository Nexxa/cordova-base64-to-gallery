
//
//  Base64ToGallery.m
//  Base64ToGallery PhoneGap/Cordova plugin
//
//  Copyright (c) 2016 StefanoMagrassi <stefano.magrassi@gmail.com>
//
//  Based on Tommy-Carlos Williams "Canvas2ImagePlugin.m"
//
//	MIT Licensed
//

#import "Base64ToGallery.h"
#import <Cordova/CDV.h>

@implementation Base64ToGallery

    - (void)saveImageDataToLibrary:(CDVInvokedUrlCommand*)command
    {
        [self.commandDelegate runInBackground:^{
            self.callbackId = command.callbackId;
            self.result = nil;

            NSString *base64String = [command.arguments objectAtIndex:0];
            NSString *prefix = [command.arguments objectAtIndex:1];
            bool cameraRoll = [[command.arguments objectAtIndex:2] boolValue];
            
            if (base64String != nil && [base64String length] > 0) {
            
                NSData *imageData = [[[NSData alloc] initWithBase64EncodedString:base64String options:0] autorelease];
                UIImage *image = [[[UIImage alloc] initWithData:imageData] autorelease];

                // converts the UIImage to NSData
                NSData *pngImageData = UIImagePNGRepresentation(image);

                // image extension
                NSString *imageExtension = @".png";

                // get Timestamp
                double currentTime = CACurrentMediaTime();

                // set fileName
                NSString *timeString = [NSString stringWithFormat:@"%f", currentTime];
                timeString = [timeString stringByReplacingOccurrencesOfString:@"." withString:@""];
                NSString *fileName = [prefix stringByAppendingString: timeString];
                fileName = [fileName stringByAppendingString: imageExtension];

                NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
                NSString *libPathNoSync = [libPath stringByAppendingPathComponent:@"NoCloud"];
                NSFileManager *fileManager = [NSFileManager defaultManager];//create instance of NSFileManager
                
                // Create the directory if necessary.
                [fileManager createDirectoryAtPath:libPathNoSync withIntermediateDirectories:YES attributes:nil error:nil];
                
                NSString *imagePath = [libPathNoSync stringByAppendingPathComponent:fileName];

                // writeToFile
                bool success = [fileManager createFileAtPath:imagePath contents:pngImageData attributes:nil];
                
                if(success){
                    // write to documents folder was successfull
                    if(cameraRoll){
                        // add the image to camera roll
                        UIImage * savedImage = [UIImage imageWithContentsOfFile:imagePath];
                        UIImageWriteToSavedPhotosAlbum(savedImage, nil, nil, nil);
                    }
                    
                    CDVPluginResult * pluginResult  = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: imagePath];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];

                }else{
                    imagePath = [imagePath stringByAppendingString: @" - error writing image to documents folder"];
                    CDVPluginResult * pluginResult  = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:imagePath];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
                }

            } else {
                CDVPluginResult * pluginResult  = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no valid base64 image data was passed"];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
            }

        }];
    }

@end
