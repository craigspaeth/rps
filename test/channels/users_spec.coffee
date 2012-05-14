process.env.NODE_ENV = 'test'
sinon = require 'sinon'
db = require "#{process.cwd()}/config/db"
io = require "#{process.cwd()}/config/io"
require "#{process.cwd()}/channels/users"
EventEmitter = require('events').EventEmitter
_ = require 'underscore'

socket = null

before ->
  _.extend io.sockets, EventEmitter.prototype
  socket = new EventEmitter()
  socket.broadcast = new EventEmitter()
  io.sockets.emit 'connection', socket

describe 'on users/logout', ->
  
  it 'will set a user inactive and broadcast a logout', (done) ->
    done = _.after 2, done
    db.stubFindAndModify { foo: 'bar' }, (query) ->
      query.$set.active.should.not.be.ok
      done()
    socket.broadcast.on 'users/logout', (data) ->
      data.foo.should.equal 'bar'
      done()
    socket.emit 'users/logout', { _id: '4f94627e0d3dd2b5011452fc' }
    
describe 'on users/login', ->
  
  it 'will set a user inactive and broadcast a login', (done) ->
    done = _.after 2, done
    db.stubFindAndModify { foo: 'bar' }, (query) ->
      query.$set.active.should.be.ok
      done()
    socket.broadcast.on 'users/login', (data) ->
      data.foo.should.equal 'bar'
      done()
    socket.emit 'users/login', { _id: '4f94627e0d3dd2b5011452fc' }