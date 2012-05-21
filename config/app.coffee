# 
# Generic app configuration
# 

express = require 'express'
everyauth = require 'everyauth'
app = module.exports = express.createServer()

app.configure ->
  @set 'views', "#{process.cwd()}/app/templates"
  @set 'view engine', 'jade'
  @set 'view options', { layout: false, pretty: true }
  @use express.bodyParser()
  @use express.methodOverride()
  @use express.cookieParser()
  @use express.session secret: 'r0ck p4p3r sc1ss0rz'
  @use everyauth.middleware()
  @use @router
  @use express.static "#{process.cwd()}/public"
  
app.configure 'development', ->
  @set 'port', 3000 || NODE_PORT
  
app.configure 'test', ->
  @set 'port', 5000 || NODE_PORT