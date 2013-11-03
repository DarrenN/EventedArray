require
  urlArgs : ''
  baseUrl : 'js'
  paths :
    underscore : '../../build/js/lib/underscore/underscore-min'
    enumerable : '../../build/js/Enumerable'
  shim :
    'underscore' :
      exports : '_'

require [
  'underscore',
  'enumerable',
  'EnumerableRequireSpec'
], (_, Enumerable, EnumerableRequireSpec) ->

  jasmineEnv = jasmine.getEnv()
  jasmineEnv.updateInterval = 1000

  htmlReporter = new jasmine.HtmlReporter()

  jasmineEnv.addReporter htmlReporter

  jasmineEnv.specFilter = (spec) ->
    return htmlReporter.specFilter(spec);


  jasmineEnv.execute();
