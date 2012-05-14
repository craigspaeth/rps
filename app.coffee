glob = require 'glob'
_ = require 'underscore'
nap = require 'nap'

# Load app, database, socket.io interface, and configuration
require './config/auth'
app = module.exports = require './config/app'
db = require './config/db'
require './config/nap'

# Load the API routes and render the initial page
require file for file in _.flatten glob.sync './api/v1/**/*.coffee'
app.get "/", (req, res) ->
  res.render 'index',
    user: req.session.user
    nap: nap

# Start the db server, app server, and sockets
db.open ->
  app.listen app.set('port'), ->
    app.emit 'start'
    console.log "Express server listening on port #{app.address().port} in #{app.settings.env} mode"
  require file for file in _.flatten glob.sync './channels/**/*.coffee'