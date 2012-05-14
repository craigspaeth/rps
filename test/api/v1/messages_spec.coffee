process.env.NODE_ENV = 'test'
sinon = require 'sinon'
app = require "#{process.cwd()}/app"
db = require "#{process.cwd()}/config/db"
request = require 'request'

app.on 'start', ->

  describe 'GET /api/v1/msgs', ->
    
    it 'returns a list of msgs', (done) ->
      request "http://localhost:5000/api/v1/msgs", (err, req, body) ->
        body.should.equal '[{"foo":"bar"}]'
        done()
      db.stubFindToArray [{"foo":"bar"}]
              
  describe 'GET /api/v1/msg/:id', ->
    
    it 'returns a msg', (done) ->
      request "http://localhost:5000/api/v1/msg/4f94627e0d3dd2b5011452fc", (err, req, body) ->
        body.should.equal '{"foo":"bar"}'
        done()
      db.stubFindOne {"foo":"bar"}, (query) ->
        query._id.toString().should.equal '4f94627e0d3dd2b5011452fc'
        
  describe 'GET /api/v1/msgs/active', ->
    
    it 'returns active msgs'
            
  describe 'DELETE /api/v1/msg/:id', ->
    
    it 'deletes a msg', (done) ->
      request {
        url: "http://localhost:5000/api/v1/msg/4f94627e0d3dd2b5011452fc"
        method: 'DELETE'
      }, (err, req, body) ->
        body.should.equal '{"success":true}'
        done()
      db.stubRemove (query) ->
        query._id.toString().should.equal '4f94627e0d3dd2b5011452fc' 
            
  xdescribe 'POST /api/v1/msg/:id', ->
    
    it 'creates a msg', (done) ->
      request {
        url: "http://localhost:5000/api/v1/msg"
        method: 'POST'
        form: {
          body: 'Baz'
        }
      }, (err, req, body) ->
        body.should.equal '{"foo":"bar"}'
        done()
      db.stubInsert { foo: 'bar' }, (data) ->
        data.body.should.equal 'Baz'
            
  xdescribe 'PUT /api/v1/msg/:id', ->
    
    it 'updates a msg', (done) ->
      request {
        url: "http://localhost:5000/api/v1/msg/4f94627e0d3dd2b5011452fc"
        method: 'PUT'
        form: {
          name: 'Craig Spaeth'
          website: 'craigspaeth.com'
        }
      }, (err, req, body) ->
        body.should.equal '{"foo":"bar"}'
        done()
      db.stubFindAndModify { foo: 'bar' }, (setter) ->
        setter.$set.name.should.equal 'Craig Spaeth'