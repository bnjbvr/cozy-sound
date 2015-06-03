# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    track_model.coffee                                 :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/03 12:45:50 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/03 13:10:14 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# See documentation on https://github.com/aenario/cozydb/

cozydb = require 'cozydb'

module.exports = TrackModel = cozydb.getModel 'Track',
    title:     String
    artiste:   String
    album:     String
    track:     String
    year:      String
    genre:     String
    time:      String
    slug:      String
    playlists: Object
    dateAdded: {'type': Date, 'default': Date.now}
    lastPlay:  Date
    plays:     {'type': Number, 'default': 0}
