root = exports ? this

# Enumerable
# ==========
#
class Enumerable

  constructor : (values...) ->
    @values = values
    @events = {}

    # Underscore.js is required
    if (_? && typeof _ == "function") == false
      throw new Error "Underscore.js is required"

  set : (values...) ->
    if values.length > 1
      for v in values
        @set v
    else
      # if we've hit our buffer length we need to shift values off
      # the front of the stack as we add new ones
      if @buffer_length? && @values.length >= @buffer_length
        @shift()

      @values.push values[0]
      @trigger 'set', values[0]

  get : (index) ->
    val = @values[index] if @values[index]?
    if val? then @trigger 'get', val

  remove : (value) ->
    index = _.indexOf @values, value
    return @trigger('remove', false) if index == -1
    val = @values[index]
    values = @values.slice(0, index).concat(_.rest(@values, index + 1))
    @values = values
    @trigger 'remove', val

  pop : ->
    @values.pop()
    @trigger 'pop'

  shift : ->
    @trigger 'shift', @values.shift()

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

  deregister : (event) ->
    if @events[event]?
      delete @events[event]

  trigger : (event, args...) ->
    if event? && @events[event]?
      @events[event](@cleanReturnVal args)
    @cleanReturnVal args

  cleanReturnVal : (val) ->
    if _.isArray(val) && val.length == 1
      return val[0]
    else
      val

  toString : ->
    JSON.stringify @values

  setBuffer : (@buffer_length) ->
    if @values.length > 0 && @values.length > @buffer_length
      @shift v for v in @values.slice(0, @values.length - @buffer_length)


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
