// Generated by CoffeeScript 1.6.3
(function() {
  define(['enumerable', 'underscore'], function(Enumerable, _) {
    var enumerable;
    enumerable = new Enumerable();
    return describe('Enumerable', function() {
      it('should exist', function() {
        return expect(enumerable).toBeTruthy();
      });
      it('should have empty values when initialized empty', function() {
        return expect(enumerable.values).toEqual([]);
      });
      it('should have empty events when initialized empty', function() {
        return expect(enumerable.events).toEqual({});
      });
      it('should have an array of values when initialized with args', function() {
        var a, b, c;
        a = new Enumerable(1, 2, 3);
        b = new Enumerable([1, 2, 3]);
        c = new Enumerable({
          foo: 1
        }, 2, [1, 2, 3], "hi");
        expect(a.values).toEqual([1, 2, 3]);
        expect(b.values).toEqual([[1, 2, 3]]);
        return expect(c.values).toEqual([
          {
            foo: 1
          }, 2, [1, 2, 3], "hi"
        ]);
      });
      it('should provide a JSON string representation with e.toString()', function() {
        var a, arr;
        arr = [
          1, 2, {
            foo: 'bar'
          }, "koji"
        ];
        a = new Enumerable(arr);
        return expect(a.toString()).toEqual(JSON.stringify([arr]));
      });
      it('should be able to have values set with e.set(n)', function() {
        var e;
        e = new Enumerable();
        e.set(1);
        expect(e.values).toEqual([1]);
        e.set("foo");
        expect(e.values).toEqual([1, "foo"]);
        e.set({
          foo: "bar"
        });
        expect(e.values).toEqual([
          1, "foo", {
            foo: "bar"
          }
        ]);
        e.set(100, ['a']);
        return expect(e.values).toEqual([
          1, "foo", {
            foo: "bar"
          }, 100, ['a']
        ]);
      });
      it('should return values with e.get(index)', function() {
        var e;
        e = new Enumerable(1, 2, 3, "akira", [3]);
        expect(e.get(0)).toEqual(1);
        expect(e.get(2)).toEqual(3);
        return expect(e.get(4)).toEqual([3]);
      });
      it('should pop() values off the end', function() {
        var c, e, end, _i, _results, _results1;
        e = new Enumerable(1, 2, 3, 4, 5);
        c = 0;
        _results = [];
        while (++c < 5) {
          e.pop();
          end = 5 - c;
          _results.push(expect(e.values).toEqual((function() {
            _results1 = [];
            for (var _i = 1; 1 <= end ? _i <= end : _i >= end; 1 <= end ? _i++ : _i--){ _results1.push(_i); }
            return _results1;
          }).apply(this)));
        }
        return _results;
      });
      it('should shift() values off the front and return them', function() {
        var c, e, _i, _ref, _results, _results1;
        e = new Enumerable(1, 2, 3, 4, 5);
        c = 0;
        _results = [];
        while (++c < 5) {
          expect(e.shift()).toEqual(c);
          _results.push(expect(e.values).toEqual((function() {
            _results1 = [];
            for (var _i = _ref = c + 1; _ref <= 5 ? _i <= 5 : _i >= 5; _ref <= 5 ? _i++ : _i--){ _results1.push(_i); }
            return _results1;
          }).apply(this)));
        }
        return _results;
      });
      it('should remove() arbitrary values by match and return it', function() {
        var arr, d, e, o;
        e = new Enumerable(1, 2, "foo", ['a'], {
          foo: "bar"
        });
        expect(e.remove("foo")).toEqual("foo");
        expect(e.values).toEqual([
          1, 2, ['a'], {
            foo: "bar"
          }
        ]);
        expect(e.remove({
          foo: "bar"
        })).toEqual(false);
        o = {
          bar: "baz"
        };
        d = new Enumerable(1, 2, o);
        expect(d.values).toEqual([
          1, 2, {
            bar: 'baz'
          }
        ]);
        expect(d.remove(o)).toEqual({
          bar: 'baz'
        });
        expect(d.values).toEqual([1, 2]);
        expect(e.remove(['a'])).toEqual(false);
        arr = ['b'];
        e.set(arr);
        expect(e.remove(arr)).toEqual(['b']);
        return expect(e.values).toEqual([
          1, 2, ['a'], {
            foo: 'bar'
          }
        ]);
      });
      it('should allow you to each()/forEach() over its values', function() {
        var e, res;
        e = new Enumerable(1, 2, 3, 4, 5);
        res = [];
        e.each(function(i) {
          return res.push(i + 1);
        });
        expect(res).toEqual([2, 3, 4, 5, 6]);
        return expect(e.values).toEqual([1, 2, 3, 4, 5]);
      });
      it('should map() over values returning a new array', function() {
        var d, e;
        e = new Enumerable(1, 2, 3, 4, 5);
        d = e.map(function(i) {
          return i + 1;
        });
        expect(d).toEqual([2, 3, 4, 5, 6]);
        return expect(e.values).toEqual([1, 2, 3, 4, 5]);
      });
      it('should reduce() values to a new value', function() {
        var e, square, sum;
        e = new Enumerable(1, 2, 3, 4, 5);
        sum = e.reduce(function(memo, num) {
          return memo + num;
        }, 0);
        square = e.reduce(function(memo, num) {
          return memo * num;
        }, 2);
        expect(sum).toEqual(15);
        expect(square).toEqual(240);
        return expect(e.values).toEqual([1, 2, 3, 4, 5]);
      });
      it('should reduceRight() values to a new value', function() {
        var e, sumr;
        e = new Enumerable(1, 2, 3, 4, 5);
        sumr = e.reduceRight(function(memo, num) {
          return memo + num;
        }, 0);
        expect(sumr).toEqual(15);
        return expect(e.values).toEqual([1, 2, 3, 4, 5]);
      });
      it('should filter() values', function() {
        var d, e;
        e = new Enumerable(false, true, true, false);
        expect(e.filter(_.identity)).toEqual([true, true]);
        d = new Enumerable(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        return expect(d.filter(function(i) {
          return i % 2;
        })).toEqual([1, 3, 5, 7, 9]);
      });
      it('should reject() values', function() {
        var d, e;
        e = new Enumerable(false, true, true, false);
        expect(e.reject(_.identity)).toEqual([false, false]);
        d = new Enumerable(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        return expect(d.reject(function(i) {
          return i % 2;
        })).toEqual([2, 4, 6, 8, 10]);
      });
      it('should return every() value that is true', function() {
        var d, e;
        e = new Enumerable(1, 2, 3, 2, 5, 6, 2, 8);
        expect(e.every(function(i) {
          return i === 2;
        })).toEqual(false);
        d = new Enumerable(2, 4, 6, 8, 10);
        return expect(d.every(function(i) {
          return i % 2 === 0;
        })).toEqual(true);
      });
      it('should return any() value that is true', function() {
        var e;
        e = new Enumerable(1, 2, 3, 2, 5, 6, 2, 8);
        expect(e.any(function(i) {
          return i === 2;
        })).toEqual(true);
        return expect(e.any(function(i) {
          return i === 6;
        })).toEqual(true);
      });
      it('should know if its contains() a value', function() {
        var e;
        e = new Enumerable(3, 4, 8, 9, 6, 3);
        expect(e.contains(8)).toEqual(true);
        return expect(e.contains('a')).toEqual(false);
      });
      it('should be able to shuffle() values', function() {
        var e;
        e = new Enumerable(1, 2, 3, 4, 5);
        return expect(e.shuffle()).toNotEqual([1, 2, 3, 4, 5]);
      });
      it('should return the first value with first()', function() {
        var e;
        e = new Enumerable(1, 2, 3, 4, 5);
        expect(e.first()).toEqual(1);
        return expect(e.first(2)).toEqual([1, 2]);
      });
      it('should return the rest() of the values', function() {
        var e;
        e = new Enumerable(1, 2, 3, 4, 5);
        expect(e.rest()).toEqual([2, 3, 4, 5]);
        expect(e.rest(2)).toEqual([3, 4, 5]);
        return expect(e.rest(3)).toEqual([4, 5]);
      });
      it('should return the initial() values', function() {
        var e;
        e = new Enumerable(1, 2, 3, 4, 5);
        expect(e.initial()).toEqual([1, 2, 3, 4]);
        return expect(e.initial(3)).toEqual([1, 2]);
      });
      it('should return the last() values', function() {
        var e;
        e = new Enumerable(1, 2, 3, 4, 5);
        expect(e.last()).toEqual(5);
        return expect(e.last(2)).toEqual([4, 5]);
      });
      return it('should return the index of an item', function() {
        var e;
        e = new Enumerable('a', 'b', 'c', 'd', 'e');
        expect(e.indexOf('b')).toEqual(1);
        return expect(e.indexOf('e')).toEqual(4);
      });
    });
  });

}).call(this);
