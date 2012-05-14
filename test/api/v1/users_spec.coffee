process.env.NODE_ENV = 'test'
sinon = require 'sinon'
app = require "#{process.cwd()}/app"
db = require "#{process.cwd()}/config/db"
request = require 'request'

app.on 'start', ->

  describe 'GET /api/v1/users', ->
    
    it 'returns a list of users', (done) ->
      request "http://localhost:5000/api/v1/users", (err, req, body) ->
        body.should.equal '[{"foo":"bar"}]'
        done()
      db.collection = (collection, callback) ->
        callback null,
          find: ->
            toArray: (callback) ->
              callback null, [{'foo': 'bar'}]
              
  describe 'GET /api/v1/user/:id', ->
    
    it 'returns a user', (done) ->
      request "http://localhost:5000/api/v1/user/4f94627e0d3dd2b5011452fc", (err, req, body) ->
        body.should.equal '{"foo":"bar"}'
        done()
      db.collection = (collection, callback) ->
        callback null,
          findOne: (query, callback) ->
            query._id.toString().should.equal '4f94627e0d3dd2b5011452fc'
            callback null, {'foo': 'bar'}
            
  describe 'DELETE /api/v1/user/:id', ->
    
    it 'deletes a user', (done) ->
      request {
        url: "http://localhost:5000/api/v1/user/4f94627e0d3dd2b5011452fc"
        method: 'DELETE'
      }, (err, req, body) ->
        body.should.equal '{"success":true}'
        done()
      db.collection = (collection, callback) ->
        callback null,
          remove: (query, callback) ->
            query._id.toString().should.equal '4f94627e0d3dd2b5011452fc'
            callback null, 'success'
            
  describe 'POST /api/v1/user/:id', ->
    
    it 'creates a user', (done) ->
      request {
        url: "http://localhost:5000/api/v1/user"
        method: 'POST'
        form: {
          name: 'Craig Spaeth'
          website: 'craigspaeth.com'
        }
      }, (err, req, body) ->
        body.should.equal '{"foo":"bar"}'
        done()
      db.collection = (collection, callback) ->
        callback null,
          insert: (data, callback) ->
            data.name.should.equal 'Craig Spaeth'
            callback null, [{ foo: 'bar' }]
            
  describe 'PUT /api/v1/user/:id', ->
    
    it 'updates a user', (done) ->
      request {
        url: "http://localhost:5000/api/v1/user/4f94627e0d3dd2b5011452fc"
        method: 'PUT'
        form: {
          name: 'Craig Spaeth'
          website: 'craigspaeth.com'
        }
      }, (err, req, body) ->
        body.should.equal '{"foo":"bar"}'
        done()
      db.collection = (collection, callback) ->
        callback null,
          findAndModify: (query, index, setter, options, callback) ->
            setter.$set.name.should.equal 'Craig Spaeth'
            callback null, { foo: 'bar' }