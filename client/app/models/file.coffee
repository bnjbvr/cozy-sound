# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    file.coffee                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/03 18:55:35 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/03 19:52:21 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


module.exports = class File  extends Backbone.Model
    url: 'test'

    initialize: ->
        console.log "new file"
