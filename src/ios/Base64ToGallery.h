//
//  Base64ToGallery.h
//  Base64ToGallery PhoneGap/Cordova plugin
//
//	Copyright (c) 2016 StefanoMagrassi <stefano.magrassi@gmail.com>
//
//  Based on Tommy-Carlos Williams "Canvas2ImagePlugin.h"
//
//	MIT Licensed
//

#import <Cordova/CDV.h>

@interface Base64ToGallery : CDVPlugin

  @property (nonatomic, copy) NSString* callbackId;
  @property (nonatomic, assign) CDVPluginResult* result;

	- (void)saveImageDataToLibrary:(CDVInvokedUrlCommand*)command;

@end
