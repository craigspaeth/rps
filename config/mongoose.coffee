# 
# Setup mongoose connection
# 

mongoose = require 'mongoose'
app = require './app'

switch app.settings.env
  when 'development'
    mongoose.connect 'mongodb://127.0.0.1/test'