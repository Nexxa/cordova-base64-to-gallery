
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
            self.imagePath = nil;

            NSString *base64String = [command.arguments objectAtIndex:0];
            NSString *prefix = [command.arguments objectAtIndex:1];
            bool cameraRoll = [command.arguments objectAtIndex:2];

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

                NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                self.imagePath = [docPath stringByAppendingString: @"/"];
                self.imagePath = [self.imagePath stringByAppendingString: fileName];

                // writeToFile
                NSError *error = nil;
                //bool success = 
                [pngImageData writeToFile:self.imagePath atomically:YES error:&error];
                
                if (error) {
                    CDVPluginResult * pluginResult  = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
                }
                //if(success){
                    // write to documents folder was successfull
                    if(cameraRoll){
                        // add the image to camera roll
                        //UIImage * savedImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSURL URLWithString:self.imagePath] path]]];
                        //UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(thisImage:wasSavedToPhotoAlbumWithError:contextInfo:), nil);
                        self.imagePath = [self.imagePath stringByAppendingString: @" - add to cameraRoll"];
                        CDVPluginResult * pluginResult  = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: self.imagePath];
                        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
                    }else{
                        CDVPluginResult * pluginResult  = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: self.imagePath];
                        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
                    }

                //}else{
                //    self.imagePath = [self.imagePath stringByAppendingString: @" - error writing image to documents folder"];
                //    CDVPluginResult * pluginResult  = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:self.imagePath];
                //    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
                //}

            } else {
                CDVPluginResult * pluginResult  = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no valid base64 image data was passed"];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
            }

        }];
    }

    - (void)thisImage:(UIImage *)image wasSavedToPhotoAlbumWithError:(NSError *)error contextInfo:(void*)ctxInfo {
        if (error) {
            CDVPluginResult * pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
        } else {
            CDVPluginResult * pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:self.imagePath];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
        }
    }

@end
