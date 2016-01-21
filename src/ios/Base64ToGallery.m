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

            //NSData* imageData = [NSData dataFromBase64String:[command.arguments objectAtIndex:0]];

            CDVPluginResult* pluginResult = nil;
            NSString* base64String = [command.arguments objectAtIndex:0];

            if (base64String != nil && [base64String length] > 0) {

                NSData* imageData = [[[NSData alloc] initWithBase64EncodedString:base64String options:0] autorelease];
                UIImage* image = [[[UIImage alloc] initWithData:imageData] autorelease];

                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

            } else {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];

                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }

        }];
    }

    - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
    {
        CDVPluginResult* result = nil;

        // With errors
        if (error != NULL) {
            NSLog(@"ERROR: %@", error);

            result = [CDVPluginResult resultWithStatus: CDVCommandStatus_ERROR messageAsString:error.description];

    		//[self.webView stringByEvaluatingJavaScriptFromString:[result toErrorCallbackString: command.callbackId]];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

        // No errors
        } else {

    		result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK];

            //[self.webView stringByEvaluatingJavaScriptFromString:[result toSuccessCallbackString: command.callbackId]];
        }

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }

@end
