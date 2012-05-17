class window.SidebarView extends Backbone.View
  
  el: '#right'
  
  initialize: ->
    onlineUsers.on 'add reset remove', @renderOnlineUsers
    
  renderOnlineUsers: =>
    @$('#online_players').html (onlineUsers.map (user) -> "<li>#{user.get('name')}</li>").join('')