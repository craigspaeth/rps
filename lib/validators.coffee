# 
# A library of data validators for resources
# 

check = require('validator').check

@user = (data) ->
  check(data.email).isEmail() if data.email
  {
    name:       data.name
    email:      data.email
    twitter_id: data.twitter_id
    website:    data.website
  }