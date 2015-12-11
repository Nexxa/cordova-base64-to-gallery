# Cordova base64ToGallery Plugin
This plugin (based on [devgeeks/Canvas2ImagePlugin](http://github.com/devgeeks/Canvas2ImagePlugin)) allows you to save base64 data as a png image into the device (iOS Photo Library, Android Gallery or WindowsPhone 8 Photo Album).

The plugin is a kind of fork of the [solderzzc/Base64ImageSaverPlugin](https://github.com/solderzzc/Base64ImageSaverPlugin) but with a cleaner history (a.k.a: no tags from Canvas2ImagePlugin repo).

## Usage
Call the `cordova.base64ToGallery()` method using success and error callbacks and the id attribute or the element object of the canvas to save:

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

## License
The MIT License

Copyright (c) 2011 Tommy-Carlos Williams ([http://github.com/devgeeks](http://github.com/devgeeks))

Copyright (c) 2015 Simba Zhang ([http://github.com/solderzzc](http://github.com/solderzzc))

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
