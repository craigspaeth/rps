class window.Feed extends Backbone.Collection
  
  initialize: ->
    socket.on 'msgs/new', (data) => @add new Msg data
    
  fetchMsgs: ->
    $.getJSON('/api/v1/msgs').then (msgs) => @add msgs