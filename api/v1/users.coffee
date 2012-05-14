app = require "#{process.cwd()}/config/app"
db = require "#{process.cwd()}/config/db"
ObjectID = require('mongodb').ObjectID
check = require('validator').check
_ = require 'underscore'
_.mixin compactObj: (obj) -> delete obj[key] unless val for key, val of obj; obj

app.get '/api/v1/users', (req, res) ->
  db.collection 'users', (err, collection) ->
    collection.find().toArray (err, data) ->
      res.end JSON.stringify data

app.get '/api/v1/user/:id', (req, res) ->
  db.collection 'users', (err, collection) ->
    collection.findOne { '_id': new ObjectID(req.params.id) }, (err, data) ->
      res.end JSON.stringify data

app.del '/api/v1/user/:id', (req, res) ->
  db.collection 'users', (err, collection) ->
    collection.remove { '_id': new ObjectID(req.params.id) }, (err, count) ->
      res.end JSON.stringify { success: err || true }
    
app.post '/api/v1/user', (req, res) ->
  data = validate req.body
  db.collection 'users', (err, collection) ->
    collection.insert data, (err, docs) ->
      res.end JSON.stringify docs[0]
    
app.put '/api/v1/user/:id', (req, res) ->
  data = validate _.extend req.body, { id: req.params.id }
  db.collection 'users', (err, collection) ->
    collection.findAndModify(
      { '_id': new ObjectID(req.params.id) }
      [['_id','asc']]
      { $set: data }
      { new: true }
      (err, data) ->
        res.end JSON.stringify data
    )

validate = (data) ->
  check(data.email).isEmail() if data.email
  _.compactObj {
    name:       data.name
    email:      data.email
    twitter_id: data.twitter_id
    website:    data.website
  }