###
    Inherited from playqueue (for the drag and drop feature)

    Features :
    - queue the entire list
    - list backed up on server side
###

Tracklist = require '../tracklist/tracklist'
PlayQueueView = require '../playqueue/playqueue'
BaseView = require './../../../lib/base_view'
TrackView = require './playlist_item'
PlaylistTrackCollection = require 'collections/playlist'

module.exports = class PlayListView extends PlayQueueView

    template: require('views/templates/playlist')
    itemview: TrackView

    events:
        'update-sort': 'updateSort'
        'click #playlist-play': 'onClickPlay'
        'remove-item': (e, track)->
            @collection.remove track

    #initialize: (param) ->
        #@collection = new PlaylistTrackCollection
            #trackId: param.trackId
            #playlistId: param.playlistId
        #super

    onClickPlay: (event)->
        event.preventDefault()
        event.stopPropagation()
        # clear the queue
        app = require 'application'
        app.playQueue.deleteFromIndexToEnd 0
        # queue the songs
        filteredCollection = @collection.filter (track) ->
            track.attributes.state is 'server'
        Backbone.Mediator.publish 'tracks:queue', filteredCollection
        # go to "up next"
        app.router.navigate "playqueue", true

    updateSort: (event, track, newPosition) ->
        @collection.move newPosition, track
