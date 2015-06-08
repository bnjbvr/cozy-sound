# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    top_nav.coffee                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/05 17:34:07 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/08 18:07:22 by ppeltier         ###   ########.fr        #
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
        'click #youtube-import' : 'onClickYoutube'
        'click #broadcast' : 'onClickBroadcast'

        # Little hack before the right CSS
        'click #upload-form' : 'onClick'
        # The event work well if upload-form is just an input but... the CSS...
        #'change #upload-form': 'onFilesChanged'

    afterRender: ->
        # Go with the event change #upload-form
        #@uploader = @$('#uploader')

        # Hack begining
        @setupHiddenFileInput()

    # Delete this when I can, don't pretty at all
    setupHiddenFileInput: =>
        document.body.removeChild @hiddenFileInput if @hiddenFileInput
        # create a hidden input file and append it at the end of the document
        @hiddenFileInput = document.createElement "input"
        @hiddenFileInput.setAttribute "type", "file"
        @hiddenFileInput.setAttribute "multiple", "multiple"
        @hiddenFileInput.setAttribute "accept", "audio/*"
        # Not setting `display="none"` because some browsers don't accept clicks
        # on elements that aren't displayed.
        @hiddenFileInput.style.visibility = "hidden"
        @hiddenFileInput.style.position = "absolute"
        @hiddenFileInput.style.top = "0"
        @hiddenFileInput.style.left = "0"
        @hiddenFileInput.style.height = "0"
        @hiddenFileInput.style.width = "0"
        document.body.appendChild @hiddenFileInput
        @hiddenFileInput.addEventListener "change", @onUploadFormChange

    # Delete this to
    onUploadFormChange: (event)=>
        # fetch files
        @handleFiles @hiddenFileInput.files

        # clear input field
        @setupHiddenFileInput()

    # part of the little hack too
    onClick: (event)->
        event.preventDefault()
        event.stopPropagation()
        # Forward the click
        @hiddenFileInput.click()

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

        # Add a tracks to the list, to avoid browser freezing,
        # after 20 tracks, it waits for 10ms (and release execution loop)
        addPhotoAndBreath = (file, callback) =>
            track = @addTrack file
            if uploadCounter > 20
                setTimeout callback, 10
            else
                uploadCounter++
                callback()
        async.eachSeries files, addPhotoAndBreath, =>
        # Some stuff after:

    addTrack: (file) =>
        track = new TrackModel
            title: file.name
            size: file.size
            type: file.type
        track.file = file
        app.tracks.unshift track,
            sort: false
        track.set
            state: 'client'
        uploadTrackModel.process track
        track


    onClickYoutube: (event) =>
        event.preventDefault()
        event.stopPropagation()
        defaultMsg = "Please enter a youtube url :"
        defaultVal = "http://www.youtube.com/watch?v=KMU0tzLwhbE"
        isValidInput = false
        until isValidInput
            input = prompt defaultMsg, defaultVal
            # if user canceled the operation
            return unless input?
            # if https then turn it into http
            if input.match /^https/
                input = input.replace /^https:\/\//i, 'http://'
            if input.match /^http:\/\/www.youtube.com\/watch?/
                startIndex = input.search(/v=/) + 2
                isValidInput = true
                youId = input.substr startIndex, 11
                console.log youId
                console.log input
            else if input.match /^http:\/\/youtu.be\//
                isValidInput = true
                youId = input.substr 16, 11
            else if input.length is 11
                isValidInput = true
                youId = input
            defaultMsg = "Invalid youtube url, please try again :"
            defaultVal = input

        # if not on home, go to home
        curUrl = "#{document.URL}"
        if curUrl.match(/playlist/) or curUrl.match(/playqueue/)
            app.router.navigate '', true

        uploadTrackModel.processYoutube youId
