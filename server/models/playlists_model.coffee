# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    playlists_model.coffee                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/10 14:31:36 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/11 12:12:28 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

cozydb = require 'cozydb'

module.exports = PlaylistsModel = cozydb.getModel 'Playlists',
    title:            type: String, default: ''
    comment:          type: String, default: '' # May use in future
    public:           type: Boolean,default: false # May use in future
    dateCreated:      type: Date,   default: Date()
    lastPlay:         type: Date,   default: Date()
    lastModified:     type: Date,   default: Date()
    size:             type: Number, default: 0
    plays:            type: Number, default: 0
    trackId:          type: [String]
