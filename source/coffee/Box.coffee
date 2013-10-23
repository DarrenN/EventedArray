root = exports ? this

class Box
  constructor : (point, @parent) ->
    @id = "box_" + new Date().getTime()
    @point = {}
    [@point.x, @point.y] = point
    @buildBox()


  buildBox :  ->
    div = $("<div class=\"box\" id=\"#{@id}\">").css
      height: 20
      width: 20
      position: 'absolute'
      top: @point.y - 10
      left: @point.x - 10
      display: 'none'
      backgroundColor: "rgb(#{_.random(0,255)}, #{_.random(0,255)}, #{_.random(0,255)})"
      
    @parent.append div
    this

  showBox : ->
    @parent.find("##{@id}").fadeIn 'fast'

  hideBox : ->
    @parent.find("##{@id}").fadeOut 'fast', ->
      $(this).remove()
  

# Do some checking of the global space to see if we're in AMD /
# Node.js land
if typeof module == 'object' && module && typeof module.exports == 'object'
  module.exports = Box
else if typeof exports == 'object' && exports
  exports.Box = Box
else if typeof define == 'function' && define.amd
  define 'box', [], -> return Box
else
  root.Box = Box
