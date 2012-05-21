process.env.NODE_ENV = 'test'
_ = require 'underscore'
sinon = require 'sinon'
app = require "/Users/craigspaeth/rps/app"
request = require 'request'
mongoose = require 'mongoose'
Msg = mongoose.model 'Msg'
fabricate = require "#{process.cwd()}/test/helpers/fabricate"

describe 'GET /api/v1/msgs', ->

  it 'returns a list of msgs', (done) ->
    stub = sinon.stub mongoose.Query.prototype, 'run', (callback) ->
      @options.sort[0][0].should.equal 'created_at'
      @options.sort[0][1].should.equal -1
      @options.limit.should.equal 10
      callback null, [fabricate('msg', body: 'foo'), fabricate('msg')]
    request "http://localhost:5000/api/v1/msgs", (err, req, body) ->
      JSON.parse(body)[0].body.should.equal 'foo'
      done()
      stub.restore()
      
describe 'POST /api/v1/msg', ->

  it 'creates a new msg', (done) ->
    stub = sinon.stub Msg.prototype, 'save', (callback) ->
      console.log "MOO"
      callback null, fabricate('msg', body: 'foo')
    request {
      url: "http://localhost:5000/api/v1/msgs"
      method: 'POST'
      form:
        _id: 'foo'
      session: 'foo'
    }, (err, req, body) ->
      console.log body
      done()
      stub.restore()