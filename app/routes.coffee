# 
# All non-api/socket-channel rotues
# 

app = require "#{process.cwd()}/config/app"
nap = require 'nap'

app.get "/", (req, res) ->
  if req.session.user?
    res.render 'index',
      user: req.session.user
      nap: nap
  else
    res.redirect '/auth/twitter'
    
app.error (err, req, res) ->
  res.send JSON.stringify({ error: err.toString() }), 500