# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_processor.coffee                              :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/04 12:40:57 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/04 18:53:30 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


# read the file from track.file using a FileReader
# create track.img : an Image object
readFile = (track, next) ->
    if track.file.size > 100 * 1024 * 1024
        return next 'is too big (max 100Mo)'

    unless track.file.type.match /audio\/(mp3|mpeg)/ # list of supported filetype
        return next 'is not an image'

    reader = new FileReader()
    track.img = new Image()
    reader.readAsDataURL track.file
    reader.onloadend = =>
        track.img.src = reader.result
    reader.onload = ->
        next()

# create a FormData object with track.file, track.thumb, track.screen
# save the model with these files
upload = (track, next) ->
    console.log "all"
    console.log track
    console.log "title"
    console.log track.get 'title'
    console.log "file"
    console.log track.file
    console.log "type"
    console.log track.get 'type'
    console.log "size"
    console.log track.get 'size'
    console.log "upload"
    formdata = new FormData()
    formdata.append 'cid', track.cid
    formdata.append 'title', "plop"#track.get 'title'
    formdata.append 'artist', track.get 'artist'
    formdata.append 'album', track.get 'album'
    formdata.append 'track', track.get 'track'
    formdata.append 'year', track.get 'year'
    formdata.append 'genre', track.get 'genre'
    formdata.append 'time', track.get 'time'
    formdata.append 'file', track.file

    # need to call sync directly so we can change the data
    console.log track.file.path
    Backbone.sync 'create', track,
        contentType: false # Prevent $.ajax from being smart
        data: formdata
        success: (data) ->
            console.log "Success!"
            track.set track.parse(data), silent: true
            next()
        error: ->
            next  ' : upload failled' # clear tmps anyway
        xhr: -> # add progress listener to XHR
            xhr = $.ajaxSettings.xhr()
            progress = (e) -> track.trigger 'progress', e

            if xhr instanceof window.XMLHttpRequest
                xhr.addEventListener 'progress', progress, false
            if xhr.upload
                xhr.upload.addEventListener 'progress', progress, false
            xhr


# make screen sized version and upload
uploadWorker = (track, done) ->
    async.waterfall [
        (cb) -> readFile          track, cb
        (cb) -> upload            track, cb
        (cb) ->
            # the track is now backed by the server
            # delete all object attached to the track
            delete track.file
            setTimeout cb, 200
    ], (err) ->
        if err
            console.log "upError"
            track.trigger 'upError', err
        else
            console.log "uploadComplete"
            track.trigger 'uploadComplete'

        done err


class trackProcessor

    # upload 2 by 2
    uploadQueue: async.queue uploadWorker, 2

    process: (track) ->
        console.log "data"
        @uploadQueue.push track, (err) =>
             return console.log err if err

module.exports = new trackProcessor()
