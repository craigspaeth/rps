app = require "#{process.cwd()}/config/app"
crud = require "#{process.cwd()}/lib/crud"

app.get '/api/v1/users', crud.all('users')

app.get '/api/v1/user/:id', crud.findById('users')

app.get '/api/v1/users/online', (req, res) ->
  crud.find('users', { 'active': true }) req, res

app.del '/api/v1/user/:id', crud.delById('users')
    
app.post '/api/v1/user', crud.create('users')
    
app.put '/api/v1/user/:id', crud.updateById('users')