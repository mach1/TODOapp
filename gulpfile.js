var gulp = require('gulp'),
    gutil = require('gulp-util'),
    jshint = require('gulp-jshint'),
    browserify = require('gulp-browserify'),
    concat = require('gulp-concat'),
    clean = require('gulp-clean'),
    refresh = require('gulp-livereload'),
    lrserver = require('tiny-lr')(),
    livereload = require('connect-livereload'),
    nodemon = require('gulp-nodemon');
    notify = require('gulp-notify');
    livereloadport = 35729,
    serverport = 5000;

var paths = {
  styles : ['webapp/app/styles/*.css'],
  scripts : ['webapp/app/scripts/*.js'],
  html : ['webapp/app/*.html', 'webapp/app/views/*.html']
};
  
gulp.task('serve', function() {
  nodemon({ script: './server/bin/server', ignore: './webapp'});
});

gulp.task('lint', function() {
  gulp.src('weapp/app/scripts/*.js')
  .pipe(jshint())
  .pipe(jshint.reporter('jshint-stylish'));
});

gulp.task('styles', function() {
  gulp.src('webapp/app/styles/*.css')
  .pipe(gulp.dest('webapp/dist/css'))
  .pipe(refresh(lrserver));
});

gulp.task('browserify', function() {
  gulp.src(['webapp/app/scripts/main.js'])
  .pipe(browserify({
    insertGlobals: true,
    debug: true
  }))
  .pipe(concat('bundle.js'))
  .pipe(gulp.dest('webapp/dist/js'))
  .pipe(refresh(lrserver))
  .pipe(notify({ message: 'Browserified'}));
});


gulp.task('html', function() {
  gulp.src('webapp/app/index.html')
  .pipe(gulp.dest('webapp/dist/'))
  .pipe(refresh(lrserver));

  gulp.src('webapp/app/views/**/*')
  .pipe(gulp.dest('webapp/dist/views/'))
  .pipe(refresh(lrserver));

  gulp.src('./webapp/app/views/*.html')
  .pipe(gulp.dest('./webapp/dist/views/'))
  .pipe(refresh(lrserver))
  .pipe(notify({ message : 'html reloaded'}));

});

gulp.task('livereload', function() {
  lrserver.listen(livereloadport, function(err) {
    if(err) {
      return console.error(err);
    }
  });
});

gulp.task('build', ['copyDeps', 'html', 'styles', 'lint', 'browserify']);
gulp.task('watch', function() {
  gulp.watch(paths.scripts, ['lint', 'browserify']);
  gulp.watch(paths.html, ['lint', 'html']);
  gulp.watch(paths.styles, ['styles']);
});

gulp.task('copyDeps', function() {
  gulp.src('./webapp/node_modules/bootstrap/dist/css/bootstrap.css')
  .pipe(gulp.dest('./webapp/dist/css'));
});


gulp.task('default', ['build', 'livereload', 'serve', 'watch']);
