class window.ChatView extends Backbone.View
  
  el: '#left footer'
  
  initialize: ->
    @$input = @$('input')
  
  events:
    'keyup input': 'submit'
    'click button.submit': 'submit'
    
  submit: (event) ->
    return if event.keyCode? and event.keyCode isnt 13 or @$input.val() is ''
    new Msg(body: @$input.val()).save()
    @$input.val ''