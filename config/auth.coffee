# 
# Configure everyauth to create a user via twitter
# 

everyauth = require 'everyauth'
  
@findOrCreateTwitterUser = (session, accessToken, accessTokenSecret, twitterUserMetadata) ->
  promise = @Promise()
  data = {
    name: twitterUserMetadata.name
    twitter_id: twitterUserMetadata.id
    website: twitterUserMetadata.url
  }
  require('./db').collection 'users', (err, collection) ->
    collection.findAndModify { 'twitter_id': data.twitter_id }, 
      [['_id','asc']], { $set: data }, { new: true,  upsert: true }, (err, data) ->
        session.user = data
        promise.fulfill data
  return promise
  
everyauth.twitter
  .consumerKey('lZXnAhvZAfOkiQvV11fnEA')
  .consumerSecret('FRLazLWChrfYmbb9marlWKKVRoyvt6l2a4bxvNrB6us')
  .findOrCreateUser(@findOrCreateTwitterUser)
  .redirectPath('/')