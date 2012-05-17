app = require "#{process.cwd()}/config/app"
crud = require "#{process.cwd()}/lib/crud"
io = require "#{process.cwd()}/config/io"

app.get '/api/v1/msgs', crud.all('msgs')

app.get '/api/v1/msgs/:id', crud.findById('msgs')

app.del '/api/v1/msgs/:id', crud.delById('msgs')

app.post '/api/v1/msgs', (req, res) ->
  if req.session.user?
    io.sockets.emit 'msgs/new', req.body
    req.body.user_id = req.session.user
    crud.create('msgs') req, res
  else
    res.send 'Unauthorized', 403

app.put '/api/v1/msgs/:id', crud.updateById('msgs')