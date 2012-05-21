# 
# Connect socket interface with app
# 

io = require 'socket.io'

module.exports = io.listen require('./app'), log: off