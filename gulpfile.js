var gulp = require('gulp')
var concat = require('gulp-concat')

gulp.task('build:js', function () {
  return gulp.src('app/assets/javascript/**/*.js')
    .pipe(concat('application.js'))
    .pipe(gulp.dest('vendor/assets/javascripts/'))
})

gulp.task('build:css', function () {
  return gulp.src('app/assets/stylesheets/**/*.css')
    .pipe(gulp.dest('vendor/assets/stylesheets/'))
})

gulp.task('watch:js', function () {
  gulp.watch('app/assets/javasript/**/*.js', ['build:js'])
})

gulp.task('watch:css', function () {
  gulp.watch('app/assets/stylesheets/**/*.css', ['build:css'])
})

gulp.task('watch', ['watch:js', 'watch:css'])
gulp.task('build', ['build:js', 'build:css'])
