# 
# Configure Node Asset Packager
# 

nap = require 'nap'

nap
  assets:
    js:
      all: [
        "app/client/vendor/jquery.js"
        "app/client/vendor/underscore.js"
        "app/client/vendor/backbone.js"
        "app/client/vendor/socket.io.js"
        "app/client/lib/**/*.coffee"
        "app/client/models/**/*.coffee"
        "app/client/collections/**/*.coffee"
        "app/client/views/**/*.coffee"
        "app/client/routers/**/*.coffee"
        "app/client/app.coffee"
      ]
    css:
      all: ["app/stylesheets/**/*.styl"]
    jst:
      all: [
        "app/templates/users/**/*.jade"
      ]