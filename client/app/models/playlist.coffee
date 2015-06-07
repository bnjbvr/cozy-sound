# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    playlist.coffee                                    :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/06 17:14:20 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/07 17:27:15 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

PlaylistTrackCollection = require '../collections/playlist'
app = require 'application'

module.exports = class Playlist extends Backbone.Model

    # This field is required to know from where data should be loaded.
    urlRoot: "playlists"

    initialize: ->
        super
        @listenTo @, 'change:id', (e)=>
            @tracks.playlistId = "#{@id}"
            @tracks.url = "playlists/#{@id}"

        console.log "test1.2"
        @tracks = new PlaylistTrackCollection false,
            url: "playlists/#{@id}"
        @tracks.playlistId = "#{@id}"

        console.log "test1.3"
        if @id?
            console.log "test1.4.1"
            @tracks.fetch()
            console.log "test1.4.2"
        else
            console.log "test1.4.3"
            @listenToOnce @, 'sync', (e)=>
                @tracks.fetch()

    destroy: ->
        # if this list is beeing displayed navigate to home
        curUrl = "#{document.URL}"
        str = "#playlist/#{@id}"
        regex = new RegExp str
        if curUrl.match regex
            app.router.navigate '', true
        # empty playlist
        # this emptying method avoid us to encounter issues with indexes
        until @tracks.length is 0
            track = @tracks.first()
            @tracks.remove track
        # then destroy it
        super
        # return false, for the super to be call
        false
