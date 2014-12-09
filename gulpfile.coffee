gulp = require 'gulp'
gutil = require 'gulp-util'
jshint = require 'gulp-jshint'
browserify = require 'gulp-browserify'
concat = require 'gulp-concat'
clean = require 'gulp-clean'
refresh = require 'gulp-livereload'
lrserver = require('tiny-lr')()
livereload = require 'connect-livereload'
nodemon = require 'gulp-nodemon'
notify = require 'gulp-notify'
livereloadport = 35729
serverport = 5000

paths =
  styles : ['webapp/app/styles/*.css']
  scripts : ['webapp/app/scripts/*.coffee', 'webapp/app/scripts/**/*.coffee']
  html : ['webapp/app/*.html', 'webapp/app/views/*.html']

gulp.task 'serve', ->
  nodemon
    script: './server/bin/server.coffee',
    ignore: './webapp'

gulp.task 'lint', ->
  gulp.src 'webapp/app/scripts/*.js'
    .pipe jshint()
    .pipe jshint.reporter 'jshint-stylish'

gulp.task 'styles', ->
  gulp.src 'webapp/app/styles/*.css'
    .pipe gulp.dest 'webapp/dist/css'
    .pipe refresh lrserver

gulp.task 'browserify', ->
  gulp.src 'webapp/app/scripts/main.coffee', read: false
    .pipe browserify
      debug: true
      transform: ['coffeeify']
      extensions: ['.coffee']
    .pipe concat 'bundle.js'
    .pipe gulp.dest 'webapp/dist/js'
    .pipe refresh lrserver
    .pipe notify message: 'Browserified'

gulp.task 'html', ->
  gulp.src 'webapp/app/index.html'
    .pipe gulp.dest 'webapp/dist'
    .pipe refresh lrserver

  gulp.src 'webapp/app/views/*.html'
    .pipe gulp.dest 'webapp/dist/views'
    .pipe refresh lrserver
    .pipe notify message : 'HTML reloaded'

gulp.task 'livereload', ->
  lrserver.listen livereloadport, (err) ->
    console.error err if err

gulp.task 'build', ['copyDeps', 'html', 'styles', 'lint', 'browserify']

gulp.task 'watch', ->
 gulp.watch paths.scripts, ['lint', 'browserify']
 gulp.watch paths.html, ['lint', 'html']
 gulp.watch paths.styles, ['styles']

gulp.task 'copyDeps', ->
  gulp.src 'node_modules/bootstrap/dist/css/bootstrap.css'
    .pipe gulp.dest 'webapp/dist/css'

gulp.task 'default', ['build', 'livereload', 'serve', 'watch']
