express = require 'express'

global.request = require 'request'
global.sinon = require 'sinon'
global.app = express.createServer()

before ->
  app.listen 5000, -> console.log 'Test server listening on 5000'
  
after ->
  app.close()