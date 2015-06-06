# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    file_collection.coffee                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/03 19:00:31 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/06 18:53:31 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

File    = require '../models/file'

module.exports = class FileCollection extends Backbone.Collection
    model: File
    url: 'test'

    initialize: ->
        console.log "collection created"
