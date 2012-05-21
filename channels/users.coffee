app = require "#{process.cwd()}/config/app"
io = require "#{process.cwd()}/config/io"
mongoose = require 'mongoose'
User = mongoose.model 'User'

io.sockets.on 'connection', (socket) ->
  
  socket.on 'users/logout', (u) ->
    User.findById u._id, (err, user) ->
      user.active = false
      user.save (err) -> socket.broadcast.emit 'users/login', user
  
  socket.on 'users/login', (u) ->
    User.findById u._id, (err, user) ->
      user.active = true
      user.save (err) -> socket.broadcast.emit 'users/login', user