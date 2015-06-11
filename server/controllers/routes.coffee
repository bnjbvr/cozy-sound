# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    routes.coffee                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/05 17:59:57 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/11 12:11:50 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# See documentation on https://github.com/frankrousseau/americano#routes

track           = require './track_controller'
playlist        = require './playlist_controller'
broadcast       = require './broadcast_controller'



module.exports =
    'tracks':
        get:    track.all
        post:   track.create

    'tracks/:id':
        delete: track.delete
        put:    track.update


    'tracks/:id/binary':
        get:    track.getAttachment

    'playlists':
        get:    playlist.all
        post:   playlist.create

    'playlists/:id':
        delete: playlist.delete
        get:    playlist.get

    'playlists/:playlistId/:id/:index':
        post:   playlist.add



    'broadcast':
        delete: broadcast.disable
        #post:   broadcast.create

    'broadcast/:url/:title/:artist':
        put:    broadcast.writeUrl

    'you/:url':
        get:    track.youtube
