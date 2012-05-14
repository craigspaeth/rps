# 
# An object acting as fake mongodb driver for test purpose
# 

module.exports = db =
  collection: ->
  open: (callback) -> callback()
  
  stubFindToArray: (docMocks) ->
    db.collection = (collection, callback) ->
      callback null,
        find: ->
          toArray: (callback) ->
            callback null, docMocks
  
  stubFindOne: (docMock, cb) ->
    db.collection = (collection, callback) ->
      callback null,
        findOne: (query, callback) ->
          callback null, docMock
          cb query
          
  stubRemove: (cb) ->
    db.collection = (collection, callback) ->
      callback null,
        remove: (query, callback) ->
          callback null, 'success'
          cb query
          
  stubInsert: (docMock, cb) ->
    db.collection = (collection, callback) ->
      callback null,
        insert: (d, callback) ->
          callback null, [docMock]
          cb d
          
  stubFindAndModify: (docMock, cb) ->
    db.collection = (collection, callback) ->
      callback null,
        findAndModify: (query, index, setter, options, callback) ->
          callback null, docMock
          cb setter