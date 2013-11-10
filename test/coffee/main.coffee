require
  urlArgs : ''
  baseUrl : 'js'
  paths :
    underscore : '../../build/js/lib/underscore/underscore-min'
    eventedarray : '../../build/js/EventedArray'
  shim :
    'underscore' :
      exports : '_'

require [
  'underscore',
  'eventedarray',
  'EventedArrayRequireSpec'
], (_, EventedArray, EventedArrayRequireSpec) ->

  jasmineEnv = jasmine.getEnv()
  jasmineEnv.updateInterval = 1000

  htmlReporter = new jasmine.HtmlReporter()

  jasmineEnv.addReporter htmlReporter

  jasmineEnv.specFilter = (spec) ->
    return htmlReporter.specFilter(spec);

  jasmineEnv.execute();
