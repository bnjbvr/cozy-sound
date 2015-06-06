# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    broadcast_controller.coffee                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/06 15:51:45 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/06 19:06:18 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

broadcastInfo   = require '../models/broadcast_model'

module.exports.disable = (req, res) ->
    broadcastInfo.broadcastEnabled = false
    res.status(200).send {success: 'broadcast info successfully updated'}


module.exports.writeUrl = (req, res) ->
    if  broadcastInfo.broadcastEnabled and broadcastInfo.lastPlayUrl?
        res.status(200).send
            url: broadcastInfo.lastPlayUrl
            title: broadcastInfo.lastPlayTitle
            artist: broadcastInfo.lastPlayArtist
    else
        res.status(200).send {error: 'Broadcast currently distabled'}

