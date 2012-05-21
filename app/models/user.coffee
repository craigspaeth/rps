check = require('validator').check
mongoose = require 'mongoose'
Schema = mongoose.Schema

mongoose.model 'User', new Schema
  name: String
  email: String #, validate: [((v) -> check(v).isEmail()), "Not a valid email address."]
  twitter_id: String
  website: String
  active: Boolean