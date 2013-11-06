root = exports ? this

registerListener = (list, f) -> list.push f

buffer = (size, coll, set, remove) ->
  (item) ->
    set item
    if coll.length > size then remove()
    coll

setter = (coll, listeners) ->
  (items...) ->
    items.forEach (i) ->
      coll.push i
      if listeners? then listeners.forEach (l) -> l i
    coll

remover = (coll, listeners) ->
   ->
    o = coll.shift()
    if listeners? then listeners.forEach (l) -> l o
    coll

getter = (coll, listeners) ->
  (index) ->
    i = if coll[index]? then coll[index] else undefined
    if listeners? then listeners.forEach (l) -> l i
    i


deadSongs = []
onDeadSongsAdd = []
registerListener onDeadSongsAdd, (s) -> console.log "#{s} was moved into Dead Songs"
addDeadSong = setter deadSongs, onDeadSongsAdd

songs = []
onSongAdd = []
onSongRemove = []

registerListener onSongAdd, (s) -> console.log "#{s} was added"
registerListener onSongRemove, (s) -> addDeadSong s

addSong = setter songs, onSongAdd
popSong = remover songs, onSongRemove
bufferSongs = buffer 5, songs, addSong, popSong

['Only Love Will Break Your Heart', 'Ring of Fire', 'Mother We Share', 'Royals', 'Anarchy in the UK', 'Eric B. is President', 'Modern Man', 'Gun', 'Hey Ladies', 'One Velvet Morning', 'Oblivion'].forEach (s) -> bufferSongs s

root.songs = songs
root.deadSongs = deadSongs
