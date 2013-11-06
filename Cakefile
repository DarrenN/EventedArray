fs = require 'fs'
{spawn, exec} = require 'child_process'

runCommand = (name, args...) ->
  proc =           spawn name, args
  proc.stderr.on   'data', (buffer) -> console.log buffer.toString()
  proc.stdout.on   'data', (buffer) -> console.log buffer.toString()
  proc.on          'exit', (status) -> process.exit(1) if status isnt 0

task 'watch', 'Watch source files and build JS & CSS', (options) ->
  runCommand 'coffee', '-wo', 'build/js', '-c', 'source/coffee'

task 'build', 'Build source files - including tests', (options) ->
  runCommand 'coffee', '-wo', 'test/js', '-c', 'test/coffee'
  runCommand 'coffee', '-wo', 'build/js', '-c', 'source/coffee'
