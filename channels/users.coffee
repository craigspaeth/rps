app = require "#{process.cwd()}/config/app"
db = require "#{process.cwd()}/config/db"
io = require "#{process.cwd()}/config/io"
ObjectID = require('mongodb').ObjectID

io.sockets.on 'connection', (socket) ->
  
  socket.on 'users/logout', (user) ->
    db.collection 'users', (err, users) ->
      users.findAndModify(
        { '_id': new ObjectID(user._id) }
        [['_id','asc']]
        { $set: { active: false } }
        { new: true }
        (err, data) ->
          socket.broadcast.emit 'users/logout', data
      )
  
  socket.on 'users/login', (user) ->
    db.collection 'users', (err, users) ->
      users.findAndModify(
        { '_id': new ObjectID(user._id) }
        [['_id','asc']]
        { $set: { active: true } }
        { new: true }
        (err, data) ->
          socket.broadcast.emit 'users/login', data
      )