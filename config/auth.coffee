# 
# Configure everyauth to create a user via twitter
# 

everyauth = require 'everyauth'
mongoose = require 'mongoose'
User = mongoose.model 'User'

@findOrCreateTwitterUser = (session, accessToken, accessTokenSecret, twitterUserMetadata) ->
  promise = @Promise()
  data =
    name: twitterUserMetadata.name
    twitter_id: twitterUserMetadata.id
    website: twitterUserMetadata.url
  User.findOne { twitter_id: data.twitter_id }, (err, user) ->
    user = new User(data) unless user?    
    user.save (err) -> 
      session.user = user
      promise.fulfill user
  return promise
  
everyauth.twitter
  .consumerKey('lZXnAhvZAfOkiQvV11fnEA')
  .consumerSecret('FRLazLWChrfYmbb9marlWKKVRoyvt6l2a4bxvNrB6us')
  .findOrCreateUser(@findOrCreateTwitterUser)
  .redirectPath('/')