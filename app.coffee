express = require 'express'
glob = require 'glob'
everyauth = require 'everyauth'
Promise = everyauth.Promise
mongodb = require 'mongodb'
ObjectID = mongodb.ObjectID
validate = require "./lib/validators"

global._ = require 'underscore'
global.app = module.exports = express.createServer()
global.db = new mongodb.Db "test", new mongodb.Server("127.0.0.1", 27017, {})

everyauth.twitter
  .consumerKey('lZXnAhvZAfOkiQvV11fnEA')
  .consumerSecret('FRLazLWChrfYmbb9marlWKKVRoyvt6l2a4bxvNrB6us')
  .findOrCreateUser((session, accessToken, accessTokenSecret, twitterUserMetadata) ->
    promise = @Promise()
    data = {
      name: twitterUserMetadata.name
      twitter_id: twitterUserMetadata.id
      website: twitterUserMetadata.url
    }
    db.collection 'users', (err, collection) ->
      collection.findAndModify { 'twitter_id': data.twitter_id }, 
        [['_id','asc']], { $set: data }, { new: true,  upsert: true }, (err, data) ->
          session.currentUser = data
          promise.fulfill data
    return promise
  )
  .redirectPath('/')

app.configure ->
  @set 'views', __dirname + '/templates'
  @set 'view engine', 'jade'
  @set 'view options', { layout: false, pretty: true }
  @use express.bodyParser()
  @use express.methodOverride()
  @use express.cookieParser()
  @use express.session secret: 'r0ck p4p3r sc1ss0rz'
  @use everyauth.middleware()
  @use @router
  @use express.static(__dirname + "/public")
  @use express.errorHandler dumpExceptions: true, showStack: true

require file for file in _.flatten glob.sync './api/v1/**/*'

app.get "/", (req, res) ->
  res.render 'index', { user: req.session.currentUser }

db.open (err, p_client) ->
  app.listen 3000, ->
    console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env