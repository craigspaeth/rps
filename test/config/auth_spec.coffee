_ = require 'underscore'
sinon = require 'sinon'
everyauth = require 'everyauth'
db = require "#{process.cwd()}/config/db"
auth = require "#{process.cwd()}/config/auth"

describe 'Configuring authentication', ->

  describe '#findOrCreateTwitterUser', ->
  
    it 'will find or create a user by twitter id', ->
      spy = sinon.spy db, 'collection'
      auth.findOrCreateTwitterUser.call { Promise: -> }, {}, 'foo', 'bar', { id: 'baz' }
      spy.args[0][1] null,
        findAndModify: (data) ->
          data.twitter_id.should.equal 'baz'
    
    it 'returns a promise', ->
      rtrn = auth.findOrCreateTwitterUser.call { Promise: -> 'qux' }, {}, 'foo', 'bar', { id: 'baz' }
      rtrn.should.equal 'qux'