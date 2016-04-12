/*globals cordova*/

/**
 * @file base64ToGallery PhoneGap/Cordova plugin
 * @author Tommy-Carlos Williams
 * @author Simba Zhang <solderzzc@gmail.com>
 * @author StefanoMagrassi <stefano.magrassi@gmail.com>
 * @copyright Tommy-Carlos Williams 2012. All rights reserved.
 * @license MIT
 */

// Consts
var SERVICE  = 'Base64ToGallery';
var ACTION   = 'saveImageDataToLibrary';

/**
 * Saves base64 data as image.
 * @public
 * @param  {string}   data
 * @param  {string}   [prefix]
 * @param  {function} [success]
 * @param  {function} [fail]
 * @return {undefined}
 */
module.exports = function(data, options, success, fail) {
  var prefix = '',
      mediaScanner = true;
  // Handle method call with 3 or 4 parameters (options optional)
  if (arguments.length < 4) {
    success = arguments[1];
    fail    = arguments[2];
  }else{
    if (typeof options === 'string') {
      // it's a string
      prefix = options;      
    } else if(Object(options)){
      // it's an Object
      if(typeof options.prefix !== 'undefined'){
        prefix = options.prefix;
      }
      if(typeof options.mediaScanner !== 'undefined'){
        mediaScanner = options.mediaScanner;
      }
    }
  }

  // Prepare base64 string
  data = data.replace(/data:image\/png;base64,/, '');

  return cordova.exec(ok(success), error(fail), SERVICE, ACTION, [data, prefix, media_scanner]);
};

/**
 * Gets success callback if it is defined and not null.
 * Otherwise returns a simple console.log.
 * @private
 * @param  {[function|undefined|null]} success
 * @return {function}
 */
function ok(success) {
  if (typeof success !== 'function') {
    return console.log;
  }

  return success;
}

/**
 * Gets fail callback if it is defined and not null.
 * Otherwise returns a simple console.error.
 * @private
 * @param  {[function|undefined|null]} fail
 * @return {function}
 */
function error(fail) {
  if (typeof fail !== 'function') {
    return console.error;
  }

  return fail;
}
