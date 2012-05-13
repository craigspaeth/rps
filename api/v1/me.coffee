app = require "#{process.cwd()}/config/app"
ObjectID = require('mongodb').ObjectID
validate = require "#{process.cwd()}/lib/validators"

app.get "/api/v1/me", (req, res) ->
  db.collection 'users', (err, collection) ->
    if req.session.user?
      res.end JSON.stringify req.session.user
    else
      res.end JSON.stringify error: "Unauthorized"