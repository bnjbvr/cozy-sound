# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    track_controller.coffee                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/03 12:44:28 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/03 13:19:26 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

TrackModel   = require '../models/track_model'

module.exports.all = (req, res) ->
    # Here we use the method all to retrieve all tracks stored.
    TrackModel.all (err, tracks) ->
        if err
            res.send 500, error: "Server error occured while retrieving data."
        else
            res.send 200, tracks

