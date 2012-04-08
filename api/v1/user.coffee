resourcer = require "#{process.cwd()}/lib/resourcer.coffee"

whitelistedKeys = ['name', 'email']
whitelist = (data) ->
  whitelistedData = {}
  whitelistedData[key] = data[key] for key in whitelistedKeys
  whitelistedData

app.get "/api/v1/user/:id", (req, res) ->
  resourcer.find 'user', req.params.id, (err, data) ->
    res.end JSON.stringify data
  
app.post "/api/v1/user", (req, res) ->
  resourcer.create 'user', whitelist(req.body), (err, data) ->
    res.end JSON.stringify data
    
app.put "/api/v1/user/:id", (req, res) ->
  resourcer.update 'user', req.params.id, whitelist(req.body), (err, data) ->
    res.end JSON.stringify data
    
app.del "/api/v1/user/:id", (req, res) ->
  resourcer.delete 'user', req.params.id, (err, data) ->
    res.end JSON.stringify data