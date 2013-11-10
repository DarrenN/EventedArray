root = exports ? this

###
#  Higher order functions which return functions that operate
#  on the data structures they close over.
###

registerListener = (list, f) -> list.push f

# Create a function which sets a value onto
# coll and keeps coll within size, removing
# any values exceeding that size
buffer = (size, coll, set, remove) ->
  (item) ->
    set item
    if coll.length > size then remove()
    coll

# Return a function which sets a value onto the end of coll
# and triggers any callbacks in listeners
setter = (coll, listeners) ->
  (items...) ->
    items.forEach (i) ->
      coll.push i
      if listeners? then listeners.forEach (l) -> l i
    coll

# Return a function which shifts values from coll
# and triggers any callbacks in listeners
remover = (coll, listeners) ->
   ->
    o = coll.shift()
    if listeners? then listeners.forEach (l) -> l o
    coll

# Return a function which looks for values in
# coll by numeric index and triggers any callbacks
# in listeners
getter = (coll, listeners) ->
  (index) ->
    i = if coll[index]? then coll[index] else undefined
    if listeners? then listeners.forEach (l) -> l i
    i

###
#  Queues
###

# Display x/y tuples
# ==================

$displayQueue = $('#displayqueue')
dlist         = []
dset          = setter dlist, [(i) -> $displayQueue.html(JSON.stringify(dlist))]
dpop          = remover dlist, []
dQueue        = buffer 25, dlist, dset, dpop

# Display boxes
# =============

$canvas  = $('#drawing');
blist    = []
showBox  = (b) -> b.showBox() # tell the box to render
addPoint = (b) -> dQueue b.point # add x/y to $displayQueue
bset     = setter blist, [showBox, addPoint]
bpop     = remover blist, [(b) -> b.hideBox(); b = null]
bQueue   = buffer 25, blist, bset, bpop

# Capture MouseMove
onMove = (e) ->
    bQueue new Box([e.x, e.y], $canvas)

document.getElementById('drawing').addEventListener('mousemove', onMove);
