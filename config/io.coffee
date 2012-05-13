# 
# Connect socket interface with app
# 

sio = require 'socket.io'

module.exports = sio.listen require('./app')