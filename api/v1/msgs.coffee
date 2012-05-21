# 
# API for the "msg" resource
# 

app = require "#{process.cwd()}/config/app"
mongoose = require 'mongoose'
Msg = mongoose.model 'Msg'
io = require "#{process.cwd()}/config/io"

app.get '/api/v1/msgs', (req, res) ->
  Msg.where().desc('created_at').limit(10).run (err, msgs) ->
    res.end JSON.stringify msgs
    
app.post '/api/v1/msgs', (req, res) ->
  console.log req.body
  msg = new Msg(req.body)
  console.log req.session
  msg.user_id = req.session.user._id
  msg.save (err, msg) ->
    res.end JSON.stringify msg
    io.sockets.emit 'msgs/new', msg