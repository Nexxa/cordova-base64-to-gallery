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

            NSString* base64String = [command.arguments objectAtIndex:0];

            if (base64String != nil && [base64String length] > 0) {

                NSData* imageData = [[[NSData alloc] initWithBase64EncodedString:base64String options:0] autorelease];
                UIImage* image = [[[UIImage alloc] initWithData:imageData] autorelease];

                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

            } else {
                self.result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];

                [self.commandDelegate sendPluginResult:self.result callbackId:self.callbackId];
            }

        }];
    }

    - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
    {
        // With errors
        if (error != NULL) {
            NSLog(@"ERROR: %@", error);

            self.result = [CDVPluginResult resultWithStatus: CDVCommandStatus_ERROR messageAsString:error.description];

        // No errors
        } else {

    		self.result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK];
        }

        [self.commandDelegate sendPluginResult:self.result callbackId:self.callbackId];
    }

@end
