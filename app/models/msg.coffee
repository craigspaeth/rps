check = require('validator').check
mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

mongoose.model 'Msg', new Schema
  user_id: ObjectId
  body: String
  created_at:
    type: Date
    default: Date.now