# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    routes.coffee                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/05 17:59:57 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/05 18:05:33 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# See documentation on https://github.com/frankrousseau/americano#routes

track           = require './track_controller'
playlist        = require './playlist_controller'



module.exports =
    'tracks':
        get: track.all
        post: track.create

    'playlists':
        get: playlist.all

