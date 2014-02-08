require! {
  gulp
  'gulp-util'
  'gulp-stylus'
  'gulp-livescript'
  'gulp-livereload'
  'tiny-lr'
  express
  path 
}

app         = express!
server      = tiny-lr!
EXPRESSPORT = 3001
LIVERELOADPORT = 35729

gulp.task \stylus, ->
  gulp.src \app/stylus/*.styl
    .pipe gulp-stylus!
    .pipe gulp.dest \app/css
    .pipe gulp-livereload server

gulp.task \app, ->
  gulp.src \app/src/*.ls
    .pipe gulp-livescript!
    .pipe gulp.dest \app/js

gulp.task \youmeb, ->
  gulp.src \app.ls
    .pipe gulp-livescript!
    .pipe gulp.dest \.
  gulp.src \api/controllers/*.ls
    .pipe gulp-livescript!
    .pipe gulp.dest \controllers
  gulp.src \api/models/*.ls
    .pipe gulp-livescript!
    .pipe gulp.dest \models
  gulp.src \api/migrations/*.ls
    .pipe gulp-livescript!
    .pipe gulp.dest \migrations

gulp.task \express, ->
  app.use require('connect-livereload')!
  app.use  express.static path.resolve \.
  app.listen EXPRESSPORT
  gulp-util.log 'Listening on port: ' + EXPRESSPORT

gulp.task \watch, ->
  server.listen LIVERELOADPORT, ->
    return gulp-util.log it if it
    gulp.watch \app.ls, <[youmeb]>
    gulp.watch \api/**/*.ls, <[youmeb]>
    gulp.watch \app/stylus/*.styl, <[stylus]>
    gulp.watch \app/src/*.ls, <[app]>

gulp.task \default, <[stylus app watch express youmeb]>
