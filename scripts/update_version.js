/*eslint-env node*/

// Modules
var fs     = require('fs');
var logger = require('nodemsg');
var pkg    = require('../package.json');

// CONSTS
var CONFIG_FILE = 'plugin.xml';
var PLUGIN_ID   = 'cordova-base64-to-gallery';
var ERROR_MSG   = 'No "version" attribute found - Please check '+ CONFIG_FILE +' ("version" tag must follow "id" tag)';
var REGEXP      = '(id="' + PLUGIN_ID + '" )(version="\\d+[.]\\d+[.]\\d+")';

// Logic
var version = pkg.version;
var regex   = new RegExp(REGEXP);
var config  = fs.readFileSync(CONFIG_FILE, { encoding: 'utf8'});

// Exit if version tag not found
if (!regex.test(config)) {
  logger.error(ERROR_MSG);

  process.exit(1);
}

// Set version
config = config.replace(regex, '$1version="' + version + '"');

fs.writeFileSync(CONFIG_FILE, config);
