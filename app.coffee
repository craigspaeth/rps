express = require 'express'
redis = require 'redis'
glob = require 'glob'

global._ = require 'underscore'
global.app = module.exports = express.createServer()
global.db = redis.createClient()

app.configure ->
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.set 'view options', layout: false
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + "/public")

app.configure "development", ->
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )

app.configure "production", ->
  app.use express.errorHandler()


require file for file in _.flatten glob.sync './routes/**/*'
require file for file in _.flatten glob.sync './api/v1/**/*'


app.listen 3000, ->
  console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env