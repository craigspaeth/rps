_ = require 'underscore'
sinon = require 'sinon'
everyauth = require 'everyauth'
db = require "#{process.cwd()}/config/db"
auth = require "#{process.cwd()}/config/auth"

describe 'Configuring authentication', ->

  describe '#findOrCreateTwitterUser', ->
  
    it 'will find or create a user by twitter id', ->
      spy = sinon.spy db, 'collection'
      auth.findOrCreateTwitterUser.call { Promise: -> { fulfill: -> } }, {}, 'foo', 'bar', { id: 'baz' }
      db.stubFindAndModify { foo: 'bar' }, (query) ->
        console.log query
    
    it 'returns a promise', ->
      rtrn = auth.findOrCreateTwitterUser.call { Promise: -> { fulfill: -> } }, {}, 'foo', 'bar', { id: 'baz' }
      (rtrn.fulfill.should?).should.be.ok