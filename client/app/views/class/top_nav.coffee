# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    top_nav.coffee                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/05 17:34:07 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/05 18:20:09 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

BaseView         = require 'lib/base_view'
TrackModel       = require 'models/track'
app              = require 'application'
uploadTrackModel = require 'models/uploader_model'


module.exports = class TopNav extends BaseView

    className: 'top-nav'
    tagName: 'div'
    template: require('views/templates/top_nav')

    # Register listener
    events:
        'change #uploader': 'onFilesChanged'

    afterRender: ->
        @uploader = @$('#uploader')

    # event listeners for D&D events
    onFilesChanged: (event) =>
        @goHome
        @handleFiles @uploader[0].files
        # reset the input
        old = @uploader
        @uploader = old.clone true
        old.replaceWith @uploader

    goHome: ->
        # if not on home, go to home
        curUrl = "#{document.URL}"
        if curUrl.match(/playlist/) or curUrl.match(/playqueue/)
            app.router.navigate '', true

    handleFiles: (files)=>
        uploadCounter = 0
        track = null

        # Add a photo to the collection, to avoid browser freezing,
        # after 20 pictures, it waits for 10ms (and release execution loop)
        # before adding pictures to the collection and the view.
        addPhotoAndBreath = (file, callback) =>
            track = @addTrack file
            if uploadCounter > 20
                setTimeout callback, 10
            else
                uploadCounter++
                callback()
        async.eachSeries files, addPhotoAndBreath, =>
        # Some stuff after: save reference
            app.tracks.unshift track,
                sort: false
            track.set
                state: 'client'

    addTrack: (file) =>
        track = new TrackModel
            title: file.name
            size: file.size
            type: file.type
        track.file = file
        #@collection.add test
        console.log "test"
        uploadTrackModel.process track
        track
