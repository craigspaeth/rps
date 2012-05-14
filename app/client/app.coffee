# Setup and initialize the application
$ -> if USER? then InitApp() else Login()

Login = ->
  console.log 'login mode'

InitApp = ->
  window.Socket = io.connect()
  window.CurrentUser = new User USER
  window.Router = new IndexRouter()
  Backbone.history.start pushState: true
  
  # Add the current user to active users
  Socket.emit 'users/login', CurrentUser.toJSON()
  
  # All local links should use the router to navigate, pushState FTW
  $('a:not(.refresh)').live 'click', ->
    return unless $(@).attr('href')?.match /^\//
    Router.navigate $(@).attr('href').replace(/^\/|\/$/g, ''), true
    false
  
  # Log a user out if they close their window
  window.onbeforeunload = ->
    Socket.emit 'users/logout', CurrentUser.toJSON()
    @preventDefault?()