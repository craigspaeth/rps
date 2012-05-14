# 
# Library of data filter/defaults/validation functions namespaced by the mongo collection name
# 

check = require('validator').check
_ = require 'underscore'
_.mixin compactObj: (obj) -> delete obj[key] unless val for key, val of obj; obj

@users = (data) ->
  check(data.email).isEmail() if data.email
  _.compactObj
    name: data.name
    email: data.email
    twitter_id: data.twitter_id
    website: data.website

@msgs = (data) ->
  _.compactObj
    user_id: data.user_id
    body: data.body