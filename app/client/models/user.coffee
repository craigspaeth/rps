class window.User extends Backbone.Model
  
  initialize: ->
    @set(id: @get('_id')).on 'change:_id', => @set id: @get('_id')