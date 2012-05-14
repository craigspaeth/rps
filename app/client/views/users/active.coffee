class window.ActiveUsersView extends Backbone.View
  
  el: '#active-users'
  
  initialize: ->
    @collection.on 'add remove reset', @render
    @collection.url = "/api/v1/users/active"
    @collection.fetch()
    Socket.on 'users/login', (user) =>
      @collection.add(new User(user)).trigger 'add'
    Socket.on 'users/logout', (user) =>
      @collection.remove(@collection.get user._id).trigger 'remove'
    @render()
    
  render: =>
    @$el.html JST['users/active'] users: @collection.models