# 
# Connect to a database
# 

mongodb = require 'mongodb'

module.exports = new mongodb.Db "test", new mongodb.Server("127.0.0.1", 27017, {})