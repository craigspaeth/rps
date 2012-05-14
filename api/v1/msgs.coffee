app = require "#{process.cwd()}/config/app"
crud = require "#{process.cwd()}/lib/crud"

app.get '/api/v1/msgs', crud.all('msgs')

app.get '/api/v1/msgs/:id', crud.findById('msgs')

app.del '/api/v1/msgs/:id', crud.delById('msgs')

app.post '/api/v1/msgs', crud.create('msgs')

app.put '/api/v1/msgs/:id', crud.updateById('msgs')