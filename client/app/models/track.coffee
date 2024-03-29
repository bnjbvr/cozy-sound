# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    track.coffee                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/06 17:14:00 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/11 19:37:18 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

module.exports = class Track extends Backbone.Model

    # This field is required to know from where data should be loaded.
    urlRoot: 'tracks'

    defaults: ->
        # state can be :
        # 'client', 'uploadStart', 'uploadEnd', 'server',
        # 'canceled', 'importBegin'
        state: 'server'

    # patch Model.sync so it could trigger progress event
    sync: (method, model, options)->
        progress = (e)->
            model.trigger('progress', e)

        _.extend options,
            xhr: ->
                xhr = $.ajaxSettings.xhr()
                if xhr instanceof window.XMLHttpRequest
                    xhr.addEventListener 'progress', progress, false
                if xhr.upload
                    xhr.upload.addEventListener 'progress', progress, false
                xhr

        Backbone.sync.apply @, arguments
