# EventedArray

###  An Array-like data structure in JavaScript which allows you to register callbacks on accessor/mutator operations.

Sometimes you want a simple data structure such as an Array
(`[1,2,3,4]`) that you can attach callbacks to, so that accessor &
mutator actions like set, getting, popping and shifting values from the Array will trigger
those callbacks.

Similar projects:

* [Observable-Arrays](https://github.com/mennovanslooten/Observable-Arrays)
* [array](https://github.com/MatthewMueller/array)
* [EventedArray](https://github.com/adjohnson916/EventedArray)

Unlike those projects, this one also lets you create a fixed size
array so that older values are shifted() off the front as new values
are pushed() on the end.

#### Show me:

```javascript

var e = new EventedArray(1,2,3,4,5);

// Simple setter/getter

e.toString() // [1,2,3,4,5]
e.set(1)
e.toString() // [1,2,3,4,5,1]
e.get(2) // returns 3

// Define a callback on 'set'
e.register('set', function(i) { console.log( i + ' was set!'); });

e.set('a') // console: a was set!

// Create a set sized array (buffered)

var e = new EventedArray();
e.setBuffer(4);
e.set(1,2,3,4,5);
e.toString(); // "[2,3,4,5]"
e.set('howdy');
e.toString(); // "[3,4,5,'howdy']"

```

**Simple animation demo** -
  [http://darrenn.github.io/EventedArray](http://darrenn.github.io/EventedArray)
**Flickr image search demo** -
  [/test-jsonp.html](http://darrenn.github.io/EventedArray/test-jsonp.html)
**Higher-order functional version** - [test-fanimation.html](http://darrenn.github.io/EventedArray/test-fanimation.html)


#### Lispy-flavored version

This whole shebang got started while I was playing around with
ClojureScript and Scheme and needed a listenable list. After doing
that I realized I could translate those functions easily with minimal
CoffeeScript to do the same thing in my JavaScript projects. You can
see that
[here](https://github.com/DarrenN/EventedArray/blob/master/source/coffee/FEventedArray.coffee)
and play with it in `/test/test-fanimation.html`

#### Dependencies

**Underscore.js** - I mixin a grab bag of the collection functions from Underscore to make it easy to access and iterate over the values

#### How to use:

Is ready to go with Node.js, RequireJS and dropped into the global window object. Just pull it in how you like (but remember, it needs Underscore.js)

#### License:

The MIT License (MIT)

Copyright (c) 2013 Darren Newton

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
