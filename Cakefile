i = require 'inflection'
fs = require 'fs'

task 'scaffold', 'generate scaffold code for basic crud on an API resource with tests', (options) ->
  collection = options.arguments[1]
  
  apiCode = """
    app = require "\#{process.cwd()}/config/app"
    crud = require "\#{process.cwd()}/lib/crud"

    app.get '/api/v1/#{i.pluralize collection}', crud.all('#{i.pluralize collection}')

    app.get '/api/v1/#{collection}/:id', crud.findById('#{i.pluralize collection}')

    app.del '/api/v1/#{collection}/:id', crud.delById('#{i.pluralize collection}')

    app.post '/api/v1/#{collection}', crud.create('#{i.pluralize collection}')

    app.put '/api/v1/#{collection}/:id', crud.updateById('#{i.pluralize collection}')
  """
  fs.writeFileSync "#{process.cwd()}/api/v1/#{i.pluralize collection}.coffee", apiCode
  
  attrs = JSON.parse options.arguments[2]
  
  testCode = """
    process.env.NODE_ENV = 'test'
    sinon = require 'sinon'
    app = require "#{process.cwd()}/app"
    db = require "#{process.cwd()}/config/db"
    request = require 'request'

    app.on 'start', ->

      describe 'GET /api/v1/#{i.pluralize collection}', ->

        it 'returns a list of #{i.pluralize collection}', (done) ->
          request "http://localhost:5000/api/v1/#{i.pluralize collection}", (err, req, body) ->
            body.should.equal '[{"foo":"bar"}]'
            done()
          db.stubFindToArray [{"foo":"bar"}]

      describe 'GET /api/v1/#{collection}/:id', ->

        it 'returns a #{collection}', (done) ->
          request "http://localhost:5000/api/v1/#{collection}/4f94627e0d3dd2b5011452fc", (err, req, body) ->
            body.should.equal '{"foo":"bar"}'
            done()
          db.stubFindOne {"foo":"bar"}, (query) ->
            query._id.toString().should.equal '4f94627e0d3dd2b5011452fc'

      describe 'DELETE /api/v1/#{collection}/:id', ->

        it 'deletes a #{collection}', (done) ->
          request {
            url: "http://localhost:5000/api/v1/#{collection}/4f94627e0d3dd2b5011452fc"
            method: 'DELETE'
          }, (err, req, body) ->
            body.should.equal '{"success":true}'
            done()
          db.stubRemove (query) ->
            query._id.toString().should.equal '4f94627e0d3dd2b5011452fc' 

      describe 'POST /api/v1/#{collection}/:id', ->

        it 'creates a #{collection}', (done) ->
          attrs = #{JSON.stringify(attrs)}
          request {
            url: "http://localhost:5000/api/v1/#{collection}"
            method: 'POST'
            form: attrs
          }, (err, req, body) ->
            body.should.equal '{"foo":"bar"}'
            done()
          db.stubInsert { foo: 'bar' }, (data) ->
            JSON.stringify(data).should.equal JSON.stringify(attrs)

      describe 'PUT /api/v1/#{collection}/:id', ->

        it 'updates a #{collection}', (done) ->
          attrs = #{JSON.stringify(attrs)}
          request {
            url: "http://localhost:5000/api/v1/#{collection}/4f94627e0d3dd2b5011452fc"
            method: 'PUT'
            form: attrs
          }, (err, req, body) ->
            body.should.equal '{"foo":"bar"}'
            done()
          db.stubFindAndModify { foo: 'bar' }, (setter) ->
            JSON.stringify(setter.$set).should.equal JSON.stringify(attrs)
  """
  fs.writeFileSync "#{process.cwd()}/test/api/v1/#{i.pluralize collection}_spec.coffee", testCode
  
  validateCode = """
    
    
    @#{i.pluralize collection} = (data) ->
      _.compactObj #{
      (key + ': data.' + key for key, val of attrs).join('\n    ')
      }
  """
  fname = "#{process.cwd()}/lib/validate.coffee"
  fs.writeFileSync fname, fs.readFileSync(fname) + validateCode