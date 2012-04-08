module.exports = class User
  
  constructor: (@attrs) ->
    @[key] = @attrs[key] for key, val of @attrs
    @
    
  save: (callback) ->
    db.set "user:#{@id}", JSON.stringify(@attrs), (err, res) =>
      callback?(@) unless err
    @
  
  toJSON: ->
    @attrs
  
  @create: (attrs, callback) ->
    db.incr 'next.user.id', (err, res) =>
      attrs.id = res
      new @(attrs).save(callback)
    return
    
  @find: (id, callback) ->
    db.get "user:#{id}", (err, res) =>
      callback? new @(JSON.parse(res))