Track = require '../models/track'
app              = require 'application'

module.exports = class PlaylistTrackCollection extends Backbone.Collection

    # Class goal:
    #   This collection is bind to a @tracks variable in a Playlist class. It
    #   represent all tracks contained in a specific Playlist object and is
    #   composed by
    #
    # Model that will be contained inside the collection.
    model: Track

    setAllTracks: (param) ->
        #if app.tracks.length == 0 # Controle if tracks is loaded, in case we
                                   # begin on playlist page since load track page
        tracksId = app.tracks._byId
        for value in param.trackId
            @push tracksId[value]



    #getWeight: (playlists) ->
        #return 0
        #for elem in playlists
            #if elem.id is @playlistId
                #return elem.weight
        #return false

    #add: (track, superOnly = false, options) ->
        #return super(track, options) if superOnly
        #if @size() > 0
            #last = @last()
            #lastWeight = @getWeight last.attributes.playlists
        #else
            #lastWeight = 0
        #track.sync 'create', track,
            #url: "#{@url}/#{track.id}/#{lastWeight}"
            #error: (xhr) ->
                #msg = JSON.parse xhr.responseText
                #alert "#{t('fail-add-track')} : #{msg.error}"
            #success: (playlists) ->
                #track.attributes.playlists = playlists

        ## avoiding calling super if an error occured
        #@listenToOnce track, 'sync', super

    remove: (track, superOnly = false)->
        return super(track) if superOnly
        track.sync 'delete', track,
            url: "#{@url}/#{track.id}"
            error: (xhr)->
                msg = JSON.parse xhr.responseText
                alert "#{t('fail-remove-track')} : #{msg.error}"
         #avoiding calling super if an error occured
        @listenToOnce track, 'sync', super

    move: (newP, track) ->
        oldP = @indexOf(track)
        return if newP is oldP
        if newP is 0
            prevWeight = 0
        else
            prev = if oldP < newP then @at(newP) else @at(newP-1)
            prevWeight = @getWeight prev.attributes.playlists
        if newP >= @indexOf(@last())
            nextWeight = Math.pow 2,53
        else
            next = if oldP < newP then @at(newP+1) else @at(newP)
            nextWeight = @getWeight next.attributes.playlists
        track.sync 'update', track,
            url: "#{@url}/prev/#{prevWeight}/next/#{nextWeight}/#{track.id}"
            error: (xhr)->
                msg = JSON.parse xhr.responseText
                alert "#{t('fail-move-track')} : #{msg.error}"
            success: (playlists) ->
                track.attributes.playlists = playlists
        @remove track, true
        @add track, true,
            at: newP
