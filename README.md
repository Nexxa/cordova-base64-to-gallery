# Cordova base64ToGallery Plugin
This plugin (based on [devgeeks/Canvas2ImagePlugin](http://github.com/devgeeks/Canvas2ImagePlugin)) allows you to save base64 data as a png image into the device (iOS Photo Library, Android Gallery or WindowsPhone 8 Photo Album).

The plugin is a kind of fork of the [solderzzc/Base64ImageSaverPlugin](https://github.com/solderzzc/Base64ImageSaverPlugin) but with a cleaner history (a.k.a: no tags from Canvas2ImagePlugin repo) and a newer iOS implementation.

## Alerts

### Plugin id - [issue #1](https://github.com/Nexxa/cordova-base64-to-gallery/issues/1)
In order to be more consistent with the cordova naming convention, since version 2.0 the repository name and the cordova plugin id have changed to **cordova-base64-to-gallery**.

Please uninstall the old version and reinstall the new one.

### cordova-ios > 3.8.0 - [issue #3](https://github.com/Nexxa/cordova-base64-to-gallery/issues/3)
According to the [documentation](https://github.com/apache/cordova-ios/blob/master/guides/API%20changes%20in%204.0.md#nsdatabase64h-removed), `NSData+Base64.h` class was removed starting from version 4.0.0 of the **cordova-ios platform** (and it was already deprecated from version 3.8.0).

So, cordova-base64-to-gallery plugin **from version 3.0.0** has changed the iOS implementation in order to support the changes in cordova-ios platform.

If you need to support cordova-ios < 3.8.0 please refer to [cordova-base64-to-gallery@2.0.2](https://github.com/Nexxa/cordova-base64-to-gallery/tree/2.0.2). There is also an "**old**" branch that might have some updates in the future (Android/WP8 fixes or something like that).


## Usage
Call the `cordova.base64ToGallery()` method using success and error callbacks and the id attribute or the element object of the canvas to save (`prefix` is optional):

### Methods
#### `cordova.base64ToGallery(data, [prefix, success, fail])`

Param       | Type       | Default           | Description
----------- | ---------- | ----------------- | ------------------
**data**    | *string*   |                   | base64 string
**prefix**  | *string*   | **img_**          | file's name prefix
**success** | *function* | **console.log**   | success callback
**fail**    | *function* | **console.error** | fail callback

### Example

```javascript
function onDeviceReady() {
    cordova.base64ToGallery(
        base64Data,

        'img_',

        function(msg){
            console.log(msg);
        },

        function(err){
            console.error(err);
        }
    );
}
```

## Authors and contributors
- [Tommy-Carlos Williams](http://github.com/devgeeks)
- [Simba Zhang](http://github.com/solderzzc)
- [StefanoMagrassi](http://github.com/StefanoMagrassi)
