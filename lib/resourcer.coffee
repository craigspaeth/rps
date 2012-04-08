# 
# Helper functions to CRUD resources to redis
# 

@create = (resource, data, callback) ->
  db.incr "next.#{resource}.id", (err, id) =>
    data.id = id
    @update resource, id, data, callback
  return
  
@find = (resource, id, callback) ->
  db.get "#{resource}:#{id}", (err, res) ->
    callback? err, JSON.parse res
  return

@update = (resource, id, data, callback) ->
  data.id = id
  db.set "#{resource}:#{id}", JSON.stringify(data), (err, res) ->
    callback? err, data
  return
  
@delete = (resource, id, callback) ->
  db.del "#{resource}:#{id}", (err, res) ->
    callback? err, if res is 1 then true else false
  return