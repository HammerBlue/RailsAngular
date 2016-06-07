// Karma configuration
// Generated on Fri Jan 08 2016 22:16:21 GMT+0000 (UTC)

module.exports = function(config) {
  config.set({

    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '/home/cstep/r2/',


    // frameworks to use
    // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['jasmine-jquery','jasmine'],


    // list of files / patterns to load in the browser
    files: [
      'vendor/assets/javascripts/angular/angular.js',
      'vendor/assets/javascripts/angular-route/angular-route.js',
      'vendor/assets/javascripts/angular-resource/angular-resource.js',
      'vendor/assets/javascripts/angular-mocks/angular-mocks.js',
      'vendor/assets/javascripts/**/jasmine.jquery.js',
      'app/assets/javascripts/**/*.js',
      'app/assets/javascripts/*.js',
      'spec/**/*Spec.js',
      'spec/**/*.js'
    ],


    // list of files to exclude
    exclude: [
      'spec/jasmine_examples/**/*Spec.js',
    ],


    // preprocess matching files before serving them to the browser
    // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
    },


    // test results reporter to use
    // possible values: 'dots', 'progress'
    // available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['dots'],


    // web server port
    port: 9876,

    hostname: '0.0.0.0',


    // enable / disable colors in the output (reporters and logs)
    colors: true,


    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,


    // start these browsers
    // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    // browsers: ['PhantomJS'],


    // Continuous Integration mode
    // if true, Karma captures browsers, runs the tests and exits
    singleRun: false,

    // Concurrency level
    // how many browser should be started simultaneous
    concurrency: Infinity,

    plugins: ['karma-jasmine', 'karma-jasmine-jquery', 'karma-phantomjs-launcher']
  })
}
