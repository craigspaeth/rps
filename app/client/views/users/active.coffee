class window.ActiveUsersView extends Backbone.View
  
  el: '#active-users'
  
  initialize: ->
    @collection.on 'reset', @render
    Socket.on 'users/active', (users) => @collection.reset users 
    @render()
    
  render: =>
    @$el.html JST['users/active'] users: @collection.models