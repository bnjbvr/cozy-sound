AppView = require './views/class/app_view'

TestView = require './views/class/test'
module.exports = class Router extends Backbone.Router

    routes:
        '': 'main'
        'test': 'test'
        'playqueue': 'playqueue'
        'playlist/:playlistId': 'playlist'

    initialize: ->
        #@mainView = new AppView()
        #@mainView.render()

        @test = new TestView()
        # bind keyboard events
        #@lastSeen = null
        #@atHome = false
        #Mousetrap.bind 'v', @onVKey

    #onVKey: =>
        ## toggle between the home and last seen list view
        #if @atHome
            #if @lastSeen?
                #@navigate "playlist/#{@lastSeen}", true
            #else
                #@navigate "playqueue", true
        #else
            #@navigate "", true

    main: ->
        #@atHome = true
        #@mainView.showTrackList()
        @test.render()


    # display the playlist view for an playlist with given id
    # fetch before displaying it
    playlist: (id)->
        @atHome = false
        @lastSeen = id
        @mainView.showPlayList id

    playqueue: ->
        @atHome = false
        @lastSeen = null
        @mainView.showPlayQueue()
