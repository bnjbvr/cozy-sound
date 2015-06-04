# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    playlist_model.coffee                              :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/03 16:49:09 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/04 14:36:53 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


cozydb = require 'cozydb'

module.exports = PlaylistModel = cozydb.getModel 'Playlist',
    title:     String
    dateAdded: {'type': Date, 'default': Date.now}
    lastPlay:  Date
    plays:     {'type': Number, 'default': 0}
