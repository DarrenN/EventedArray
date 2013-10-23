define ['Enumerable','underscore'], (Enumerable, _) ->
  
  enumerable = new Enumerable()
  
  describe 'Enumerable', ->

    it 'Should exist', ->
      expect(enumerable).toBeTruthy()
