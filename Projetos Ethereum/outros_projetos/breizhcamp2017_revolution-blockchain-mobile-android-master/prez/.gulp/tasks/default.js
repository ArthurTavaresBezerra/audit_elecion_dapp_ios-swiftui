'use strict';

// Necessary Plugins
var gulp = require('gulp');

// Default task
module.exports = gulp.task('default', ['js', 'jade', 'stylus', 'css', 'imagemin',
  'watch', 'browser-sync']);
