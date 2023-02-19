var gulp        = require('gulp');
var cloudfiles  = require('gulp-cloudfiles');
var fs          = require('fs')
var rackspace   = JSON.parse(fs.readFileSync('./rackspace.json'));

/**
 * Push build to cloud-files
 */
gulp.task('deploy', function () {
  return gulp.src(["./dist/**/*", "!dist/media/**"], {read: false})
    .pipe(cloudfiles(rackspace, {}));
});

gulp.task('deploy-all', function () {
  return gulp.src(["./dist/**/*"], {read: false})
    .pipe(cloudfiles(rackspace, {}));
});

gulp.task('default', ['deploy']);