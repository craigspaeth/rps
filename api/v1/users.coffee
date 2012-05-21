# 
# API for the "user" resource
# 

app = require "#{process.cwd()}/config/app"
mongoose = require 'mongoose'
User = mongoose.model 'User'

app.get '/api/v1/users/online', (req, res) ->
  User.find { active: true }, (err, users) ->
    res.end JSON.stringify users