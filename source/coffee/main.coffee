require
  urlArgs : ''
  baseUrl : '../build/js'
  paths :
    underscore : 'lib/underscore/underscore-min'
  shim :
    'underscore' :
      exports : '_'

require [
  'underscore',
  'Enumerable',
  'EnumerableRequireSpec'
], (_, Enumerable, EnumerableRequireSpec) ->

  jasmineEnv = jasmine.getEnv()
  jasmineEnv.updateInterval = 1000

  htmlReporter = new jasmine.HtmlReporter()

  jasmineEnv.addReporter htmlReporter

  jasmineEnv.specFilter = (spec) ->
    return htmlReporter.specFilter(spec);


  jasmineEnv.execute();
    
