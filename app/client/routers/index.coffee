class window.IndexRouter extends Backbone.Router
  
  _.extend @prototype, Backbone.FrameManager
  
  routes:
    '': 'index'
  
  frames:
    '': HomeView
    
  index: ->