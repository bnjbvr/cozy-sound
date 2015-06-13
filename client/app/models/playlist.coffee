# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    playlist.coffee                                    :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/06 17:14:20 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/13 14:26:13 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

app = require 'application'

module.exports = class Playlist extends Backbone.Model

    # This field is required to know from where data should be loaded.
    urlRoot: "playlists"

    # Add a array of musique id at the end of the playlist
    addTrack: (listNewId)->
        listTrackId =  @get 'trackId'
        newListTrackId = listTrackId.concat listNewId
        # update and save on server the new list
        $.ajax
            url: "playlists/post/#{@id}"
            type: 'PUT'
            data: {listNewId: listNewId, newListTrackId: newListTrackId}
            error: (xhr) ->
                msg = JSON.parse xhr.responseText
                alert "#{t('fail-add-track')} : #{msg.error}"
         # update  client list
        @set 'trackId', newListTrackId
