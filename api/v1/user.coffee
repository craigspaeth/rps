ObjectID = require('mongodb').ObjectID
validate = require "#{process.cwd()}/lib/validators"

app.get "/api/v1/user/:id", (req, res) ->
  db.collection 'users', (err, collection) ->
    collection.findOne { '_id': new ObjectID(req.params.id) }, (err, data) ->
      res.end JSON.stringify data

app.del "/api/v1/user/:id", (req, res) ->
  db.collection 'users', (err, collection) ->
    collection.remove { '_id': new ObjectID(req.params.id) }, (err, count) ->
      res.end JSON.stringify { success: err || true }
    
app.post "/api/v1/user", (req, res) ->
  data = validate.user req.body
  db.collection 'users', (err, collection) ->
    collection.insert data, (err, docs) ->
      res.end JSON.stringify docs[0]
    
app.put "/api/v1/user/:id", (req, res) ->
  data = validate.user _.extend req.body, { id: req.params.id }
  db.collection 'users', (err, collection) ->
    collection.findAndModify { '_id': new ObjectID(req.params.id) }, [['_id','asc']], { $set: data }, { new: true }, (err, data) ->
      res.end JSON.stringify data