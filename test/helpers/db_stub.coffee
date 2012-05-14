# 
# An object acting as fake mongodb driver for test purpose (spy on it's methods)
# 

module.exports =
  collection: ->
  open: (callback) -> callback()