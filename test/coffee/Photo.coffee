root = exports ? this

class Photo
  constructor : (@entry, @parent, @remove) ->
    @id = "photo_" + new Date().getTime()
    @url = @entry.media.m
    @title = if @entry.title == "" then "Ohne titel" else entry.title
    @author = @entry.author

    @buildPhoto()

  buildPhoto :  ->
    li = $("<li class=\"photo\" id=\"#{@id}\">").css
      display: 'none'

    li.append "<img src=\"#{@url}\" />"
    li.append "<h1>#{@title}</h1>"
    li.append "<h2>#{@author}</h2>"
    li.append "<a href=\"#{@id}\">Remove photo</a>"

    @parent.prepend li

    li.on 'click', 'a', (e) =>
      e.preventDefault()
      @remove this

    this

  showPhoto : ->
    @parent.find("##{@id}").fadeIn 'fast'

  hidePhoto : ->
    @parent.find("##{@id}").fadeOut 'fast', ->
      $(this).remove()


# Do some checking of the global space to see if we're in AMD /
# Node.js land
if typeof module == 'object' && module && typeof module.exports == 'object'
  module.exports = Photo
else if typeof exports == 'object' && exports
  exports.Photo = Photo
else if typeof define == 'function' && define.amd
  define 'box', [], -> return Photo
else
  root.Photo = Photo
