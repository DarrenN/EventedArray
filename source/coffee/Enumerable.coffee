root = exports ? this

# Enumerable
# ==========
# 
class Enumerable
 
  constructor : (values) ->
    @values = if values? then @handleType(values) else []
    @events = {}
 
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
 
  map : (fn) ->
    @values.map (v) =>
      @trigger 'map', v
      fn(v)
 
  forEach : (fn) ->
    @values.forEach (v) =>
      @trigger 'forEach', v
      fn(v)
    @values
 
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
  define 'Enumerable', [], -> return Enumerable
else
  root.Enumerable = Enumerable
