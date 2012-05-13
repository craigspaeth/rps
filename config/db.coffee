# 
# Connect to a database
# 

mongodb = require 'mongodb'
app = require './app'

switch app.settings.env
  when 'test' then module.exports = require "#{process.cwd()}/test/helpers/db_stub.coffee"
  when 'development' then module.exports = new mongodb.Db "test", 
    new mongodb.Server("127.0.0.1", 27017, {})