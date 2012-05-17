class window.FeedView extends Backbone.View
  
  el: '#feed'
  
  initialize: ->
    @collection.on 'add', @render
    @collection.on 'add', @scrollBottom
    @collection.fetchMsgs()
    
  render: =>
    @$el.html JST['feed'] feed: @collection.models
    
  scrollBottom: =>
    @$el.scrollTop 999 * 999