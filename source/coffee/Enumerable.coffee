root = exports ? this

# Enumerable
# ==========
# 
class Enumerable

  constructor : (values) ->
    @values = if values? then @handleType(values) else []
    @events = {}

    # Underscore.js is required
    if (_? && typeof _ == "function") == false
      throw new Error "Underscore.js is required"
 
  handleType : (value) ->
    if value?
      if value instanceof Array
        return value
      else if value instanceof Object
        return [value]
      else if typeof value == "string" || typeof value == "number"
        return [value]
    undefined

  set : (value) ->
    @values.push value
    @trigger 'set', value
 
  get : (index) ->
    val = @values[index] if @values[index]?
    if val? then @trigger 'get', val
 
  pop : ->
    @values.pop()
    @trigger 'pop'

  each : (fn, context) ->
    _.each(@values, (v) =>
      @trigger 'each', v
      fn(v)
    , context)

  map : (fn, context) ->
    @trigger 'map', _.map @values, fn, context
 
  forEach : (fn, context) ->
    @each fn, context

  reduce : (fn, memo, context) ->
    @trigger 'reduce', _.reduce @values, fn, memo, context

  reduceRight : (fn, memo, context) ->
    @trigger 'reduceRight', _.reduce @values, fn, memo, context
 
  register : (event, fn) ->
    @events[event] = fn
 
  trigger : (event, args...) ->
    if event? && @events[event]?
      @events[event](args)
    @cleanReturnVal args
 
  cleanReturnVal : (val) ->
    if val instanceof Array && val.length == 1
      return val[0]
    val
 
  toString : ->
    @values.toString()
 

# Do some checking of the global space to see if we're in AMD /
# Node.js land
if typeof module == 'object' && module && typeof module.exports == 'object'
  module.exports = Enumerable
else if typeof exports == 'object' && exports
  exports.Enumerable = Enumerable
else if typeof define == 'function' && define.amd
  define 'enumerable', [], -> return Enumerable
else
  root.Enumerable = Enumerable