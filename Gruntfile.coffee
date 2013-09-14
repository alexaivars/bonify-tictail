"use strict"
module.exports = (grunt) ->
  
  # Configure Grunt
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    requirejs:
      compile:
        options:
          # optimize: "uglify2"
          # generateSourceMaps: true
          optimize: "none"
          preserveLicenseComments: false
          baseUrl: "dist/js"
          inlineText: true
          paths:
            underscore: "empty:"
            jquery: "empty:"
            tictail: "empty:"
            mustache: "empty:"
            text: "vendor/text"
            requireLib: "vendor/require"
          stubModules: ["text"]
          include: ["requireLib","app"]
          out: "dist/js/main-build.js"

    copy:
      html:
        files: [expand: true, cwd: "html", src: ["**"], dest: "dist/"]
      libs:
        files: [expand: true, cwd: "js", src: ["**"], dest: "dist/js"]
      templates:
        files: [expand: true, cwd: "templates", src: ["**/*.tpl"], dest: "dist/js"]

    coffee:
      compile:
        options:
          nonull: true
          bare: true
        expand: true
        cwd: "coffee"
        src: ["**/*.coffee"]
        dest: "dist/js"
        ext: ".js"

    compass:
      dev:
        options:
          #basePath: "src/sass"
          force: true
          sassDir: "sass"
          cssDir: "dist/css"
          javascriptsDir: "dist/js"
          imagesDir: "image"
          raw: """output_style = :expanded
                  Sass::Script::Number.precision = 10
               """
    jasmine:
      all:
        options:
          specs: "spec/*Spec.js"
          helpers: "spec/*Helper.js"
          template: require("grunt-template-jasmine-requirejs")
          templateOptions:
            requireConfig:
              baseUrl: "dist/js"
              paths:
                # underscore: "empty:"
                jquery: "vendor/jquery"
              deps: ['jquery']
    
    watch:
      
      static:
        options:
          atBegin: true
          spawn: false
          livereload: true
        files: ["html/**/*","vendor/**/*"]
        tasks: ["copy"]
      
      ###
      styles:
        options:
          atBegin: true
          spawn: false
          livereload: true
        files: "sass/ * * / *.scss"
        tasks: ["compass"]
      ###
    
      templates:
        options:
          atBegin: true
          spawn: false
        files: "templates/**/*.tpl"
        tasks: ["copy:templates"]
      
      libs:
        options:
          atBegin: true
          spawn: false
        files: "bower.json"
        tasks: ["bower-install"]

      coffee:
        options:
          atBegin: true
          events: ['changed', 'added']
          livereload: true
        files: "coffee/**/*.coffee"
        tasks: ["newer:coffee"]


  
  # Load external tasks
  grunt.loadNpmTasks "grunt-contrib-requirejs"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-jasmine"
  grunt.loadNpmTasks "grunt-newer"
   
  # Make task shortcuts
  grunt.registerTask "default", ["copy","bower-install","coffee:compile","requirejs:compile"]



  # -- Bower Tasks --------------------------------------------------------------
  grunt.registerTask 'bower-install', 'Installs Bower dependencies.', () ->
 
    bower_json  = grunt.file.readJSON('bower.json')
    bower_dir   = 'bower_components'
    dist_dir    = 'dist/js/vendor'

    findMainFile = (name) ->
      path = "#{bower_dir}/#{name}"
      main = name + ".js"
      ["package.json", ".package.json", ".bower.json", "bower.json"].every (config) ->
        if grunt.file.isFile(path + "/" + config)
          main = grunt.file.readJSON(path + "/" + config).main.replace("./","")
          return
      return main

    copyMainFile = (name, src) ->
      grunt.log.ok("copied " + dist_dir + "/" + src.replace(/^[^/]+\//,""))
      grunt.file.copy bower_dir + "/" + name + "/" + src, dist_dir + "/" + src.replace(/^[^/]+\//,"")
      
    grunt.util._.map bower_json.dependencies, (value, key) ->
      copyMainFile key, findMainFile(key)
