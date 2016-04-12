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
var DEFAULTS = { prefix: '', mediaScanner: true };

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
  var actionArgs = prepareArgs(options);

  // Prepare base64 string
  data = data.replace(/data:image\/png;base64,/, '');

  // And add it to the Service's Action arguments
  actionArgs.unshift(data);

  return cordova.exec(ok(success), error(fail), SERVICE, ACTION, actionArgs);
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

/**
 * Prepares parameter to pass to Service's Action.<br/>
 * @private
 * @param  {object} opts - Options object
 * @return {array}  Arguments array
 */
function prepareArgs(opts) {
  var args = [];
      
  for(var index in DEFAULTS) { 
   args.push(opts.hasOwnProperty(index)? opts[index]: DEFAULTS[index]);
  }
  return args;
}
