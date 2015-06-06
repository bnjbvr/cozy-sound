# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    routes.coffee                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/05 17:59:57 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/06 18:58:22 by ppeltier         ###   ########.fr        #
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


    'tracks/:id/binary':
        get:    track.getAttachment

    'playlists':
        get:    playlist.all

    'broadcast':
        delete: broadcast.disable

    'broadcast/:url/:title/:artist':
        put:    broadcast.writeUrl

