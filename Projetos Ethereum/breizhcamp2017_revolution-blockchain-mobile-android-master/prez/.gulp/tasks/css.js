'use strict';

// Necessary Plugins
var gulp         = require('gulp');
var plumber      = require('gulp-plumber');
var paths        = require('../paths');

// Call Stylus
module.exports = gulp.task('css', function() {
  return gulp.src(paths.source.css)
    .pipe(plumber())
    .pipe(gulp.dest(paths.build.css));
});
