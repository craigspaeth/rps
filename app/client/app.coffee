# 
# Setup and initialize the application
# 
$ ->
  highjackLinksForPushState()
  logoutHandler()
  startApp()
  
startApp = ->
  window.socket = io.connect()
  window.currentUser = new User USER
  window.feed = new Feed()
  setupOnlineUsers()
  window.feedView = new FeedView collection: feed
  window.chatView = new ChatView()
  window.sideBar = new SidebarView collection: onlineUsers
  socket.emit 'users/login', currentUser.toJSON()
  
setupOnlineUsers = ->
  window.onlineUsers = new Users()
  onlineUsers.url = '/api/v1/users/online'
  onlineUsers.fetch()
  socket.on 'users/login', (user) -> onlineUsers.add user
  socket.on 'users/logout', (user) ->
    onlineUsers.remove onlineUsers.get user._id

highjackLinksForPushState = ->
  $('a:not(.refresh)').live 'click', ->
    return unless $(@).attr('href')?.match /^\//
    router.navigate $(@).attr('href').replace(/^\/|\/$/g, ''), true
    false

logoutHandler = ->
  window.onbeforeunload = ->
    socket.emit 'users/logout', currentUser.toJSON()
    @preventDefault?()