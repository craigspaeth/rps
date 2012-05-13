class window.HomeView extends Backbone.View
  
  el :'#home'
  
  initialize: ->
    @activeUsersView = new ActiveUsersView collection: new Users()