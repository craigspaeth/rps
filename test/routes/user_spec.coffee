require "#{process.cwd()}/test/helpers/routes.coffee"
require "#{process.cwd()}/routes/user.coffee"

describe "GET /user", ->
  
  it "it returns foobar", (done) ->
    request 'http://localhost:5000/user/foo', (err, res, body) ->
      body.should.equal 'foobar'
      done()