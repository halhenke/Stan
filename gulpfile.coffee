gulp = require "gulp"
jade = require "gulp-jade"
sass = require "gulp-sass"
# We need sourcemaps for gulp-sass/node-sass to work properly:
# https://github.com/dlmanning/gulp-sass/issues/81
sourcemaps = require 'gulp-sourcemaps'
inline = require 'gulp-inline-css'
savefile = require 'gulp-savefile'
plumber = require 'gulp-plumber'
concat = require 'gulp-concat'
coffee = require "gulp-coffee"
ngCache = require "gulp-angular-templatecache"

paths =
  in:
    bower:
      js: [
        "./bower_components/angular/angular.min.js"
        "./bower_components/angular-route/angular-route.min.js"
        "./bower_components/modernizr/modernizr.js"
        "./bower_components/jquery/dist/jquery.min.js"
        "./bower_components/foundation/js/foundation.min.js"
      ]
    email:
      jade: "./app/templates/email/ink/*.jade"
      sass: "./app/styles/style_email.sass"
    ng:
      jade: "./app/ng/templates/**.jade"
      coffee: "./app/ng/scripts/**.coffee"
    webpack:
      entry: "./webpack.entry.js"
      config: "./webpack.config.js"
    images: "./app/images/**"
    jade:
      pages: "./app/templates/*.jade"
      not_pages: "./app/templates/**/*.jade"
      all: "./app/templates/**.jade"
    coffee: "./app/scripts/**.coffee"
    page:
      sass: "./app/styles/style.sass"
  out:
    email: "./campaign/edm"
    ng:
      templates: "templates.js"
    html: "./campaign/page"
    js: "./campaign/page/js"
    css: "./campaign/page/css"
    images: "./campaign/page/images"


gulp.task "bower-js", ->
  return gulp.src(paths.in.bower.js)
    .pipe plumber()
    .pipe(concat("bower.js"))
    .pipe(gulp.dest(paths.out.js))

gulp.task "ng-coffee", ->
  return gulp.src(paths.in.ng.coffee)
    .pipe plumber()
    .pipe coffee()
    .pipe concat("app.js")
    .pipe(gulp.dest(paths.out.js))

gulp.task "ng-jade", ->
  return gulp.src(paths.in.ng.jade)
    .pipe plumber()
    .pipe(jade())
    .pipe(ngCache(paths.out.ng.templates, standalone: true))
    .pipe(gulp.dest(paths.out.js))

gulp.task "email-sass", ->
  return gulp.src paths.in.email.sass
    .pipe plumber()
    .pipe sass(indentedSyntax: true)
    .pipe gulp.dest(paths.out.css)

gulp.task "email-jade", ["email-sass"], ->
  return gulp.src(paths.in.email.jade)
    .pipe plumber()
    .pipe jade(
      pretty: true
      cache: false
      )
    .pipe inline()
    .pipe gulp.dest(paths.out.email)

gulp.task "assets", ->
  return gulp.src paths.in.images
    .pipe gulp.dest(paths.out.images)

# Used to trigger Jade re-compilation when Jade
# partials/mixins etc are altered
gulp.task "save-jade", ->
  return gulp.src paths.in.jade.pages
    .pipe savefile()

gulp.task "jade", ->
  return gulp.src paths.in.jade.pages
    .pipe plumber()
    .pipe jade(
      pretty: true
      cache: false
      )
    .pipe gulp.dest(paths.out.html)

gulp.task "sass", ->
  return gulp.src paths.in.page.sass
    .pipe plumber()
    .pipe sourcemaps.init()
    .pipe sass(indentedSyntax: true)
    .pipe sourcemaps.write()
    .pipe gulp.dest(paths.out.css)

gulp.task "coffee", ->
  return gulp.src paths.in.coffee
    .pipe plumber()
    .pipe coffee()
    .pipe gulp.dest(paths.out.js)


gulp.task "watch", ->
  gulp.watch paths.in.coffee, ['coffee']
  gulp.watch paths.in.jade.not_pages, ['save-jade']
  gulp.watch paths.in.jade.pages, ['jade']
  gulp.watch paths.in.page.sass, ['sass']
  gulp.watch paths.in.ng.coffee, ['ng-coffee']
  gulp.watch paths.in.ng.jade, ['ng-jade']
  # IF WE CHANGE EMAIL SASS WE WILL NEED TO RECOMPILE EMAIL JADE
  gulp.watch [paths.in.email.sass, paths.in.email.jade], ['email-jade']

gulp.task "default", ['assets', 'jade', 'sass', 'coffee', 'email-jade', 'ng-coffee', 'ng-jade', 'bower-js', 'watch']
