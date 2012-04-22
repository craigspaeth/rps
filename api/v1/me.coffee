ObjectID = require('mongodb').ObjectID
validate = require "#{process.cwd()}/lib/validators"

app.get "/api/v1/me", (req, res) ->
  db.collection 'users', (err, collection) ->
    if req.user?
      collection.findOne { '_id': new ObjectID(req.user.id) }, (err, data) ->
        res.end JSON.stringify data
    else
      res.end JSON.stringify error: "Unauthorized"