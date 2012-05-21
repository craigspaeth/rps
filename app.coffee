# 
# Sets everything up and runs the app
# 

glob = require 'glob'
_ = require 'underscore'
mongoose = require 'mongoose'

# Load models, configuration, routes, api, and socket channels
require file for file in _.flatten glob.sync './app/models/**/*.coffee'
require './config/auth'
app = module.exports = require './config/app'
require './config/mongoose'
require './config/nap'
require file for file in _.flatten glob.sync './api/v1/**/*.coffee'
require file for file in _.flatten glob.sync './channels/**/*.coffee'
require './app/routes'

# Start the db server & app server
mongoose.connection.on 'open', ->
  app.listen app.set('port'), ->
    app.emit 'start'
    console.log "Express server listening on port #{app.address().port} in #{app.settings.env} mode"