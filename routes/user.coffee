User = require '../models/user.coffee'

app.get "/user/:id", (req, res) ->
  User.find req.params.id, (user) ->
    res.end JSON.stringify user.toJSON()
  
app.post "/user", (req, res) ->
  User.create {
    name: 'Paul'
    email: 'paulspaeth@gmail.com'
  }, (user) ->
    res.end JSON.stringify user.toJSON()