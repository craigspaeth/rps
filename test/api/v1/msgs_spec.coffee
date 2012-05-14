process.env.NODE_ENV = 'test'
sinon = require 'sinon'
app = require "/Users/craigspaeth/rps/app"
db = require "/Users/craigspaeth/rps/config/db"
request = require 'request'

app.on 'start', ->

  describe 'GET /api/v1/msgs', ->

    it 'returns a list of msgs', (done) ->
      request "http://localhost:5000/api/v1/msgs", (err, req, body) ->
        body.should.equal '[{"foo":"bar"}]'
        done()
      db.stubFindToArray [{"foo":"bar"}]

  describe 'GET /api/v1/msgs/:id', ->

    it 'returns a msgs', (done) ->
      request "http://localhost:5000/api/v1/msgs/4f94627e0d3dd2b5011452fc", (err, req, body) ->
        body.should.equal '{"foo":"bar"}'
        done()
      db.stubFindOne {"foo":"bar"}, (query) ->
        query._id.toString().should.equal '4f94627e0d3dd2b5011452fc'

  describe 'DELETE /api/v1/msgs/:id', ->

    it 'deletes a msgs', (done) ->
      request {
        url: "http://localhost:5000/api/v1/msgs/4f94627e0d3dd2b5011452fc"
        method: 'DELETE'
      }, (err, req, body) ->
        body.should.equal '{"success":true}'
        done()
      db.stubRemove (query) ->
        query._id.toString().should.equal '4f94627e0d3dd2b5011452fc' 

  describe 'POST /api/v1/msgs/:id', ->

    it 'creates a msgs', (done) ->
      attrs = {"user_id":"foo","body":"baz"}
      request {
        url: "http://localhost:5000/api/v1/msgs"
        method: 'POST'
        form: attrs
      }, (err, req, body) ->
        body.should.equal '{"foo":"bar"}'
        done()
      db.stubInsert { foo: 'bar' }, (data) ->
        JSON.stringify(data).should.equal JSON.stringify(attrs)

  describe 'PUT /api/v1/msgs/:id', ->

    it 'updates a msgs', (done) ->
      attrs = {"user_id":"foo","body":"baz"}
      request {
        url: "http://localhost:5000/api/v1/msgs/4f94627e0d3dd2b5011452fc"
        method: 'PUT'
        form: attrs
      }, (err, req, body) ->
        body.should.equal '{"foo":"bar"}'
        done()
      db.stubFindAndModify { foo: 'bar' }, (setter) ->
        JSON.stringify(setter.$set).should.equal JSON.stringify(attrs)