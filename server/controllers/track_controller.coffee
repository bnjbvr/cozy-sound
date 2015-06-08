# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_controller.coffee                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/04 13:09:41 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/07 19:21:06 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

TrackModel = require '../models/track_model'
multiparty = require 'multiparty'
os         = require 'os'
path       = require 'path'
request    = require 'request-json'


module.exports.all = (req, res) ->
    console.log "Get all Tracks"
    TrackModel.request 'all', (err, data) ->
        if err
            res.status(500).send({error: "An error has occured -- #{err}"})
        else
            res.status(200).send(data)


module.exports.create = (req, res, next) ->
    cid = null
    lastPercent = 0
    files = {}
    isAllowed = not req.public

    # unlink all files in req.files
    cleanup = ->
        async.each req.files, (file, cb) ->
            fs.unlink file.path, (err) ->
                console.log 'Could not delete %s', file.path if err
                cb null # loop anyway
        , -> # do nothing

    # Parse given form to extract image blobs.
    form = new multiparty.Form
        uploadDir: '/tmp'
        defer: true # don't wait for full form. Needed for progress events
        keepExtensions: true
        maxFieldsSize: 100 * 1024 * 1024

    # Get progress to display it to the user. Data are sent via websocket.
    form.on 'progress', (bytesReceived, bytesExpected) ->
        return unless cid?
        percent = bytesReceived/bytesExpected
        return unless percent - lastPercent > 0.05
        lastPercent = percent
        #app.io.sockets.emit 'uploadprogress', cid: cid, p: percent

    form.on 'error', (err) ->
        return next err if err

    # When form is fully parsed, data are saved into CouchDB.

    form.parse req, (err, fields, files) ->
        file =  files.file[0]
        track = new TrackModel
            title:      fields.title[0]
            artist:     fields.artist[0]
            album:      fields.album
            size:       file.size
            track:      fields.track
            year:       fields.year
            genre:      fields.genre
            dateAdded:  Date()
            lastPlay:   undefined
            plays:      0

        TrackModel.create track, (err, newTrack) ->
            return next err if err
            data = name: 'source'
            newTrack.attachBinary files.file[0].path, data, (err) ->
                if err
                    console.log err
                else
                    console.log "NewTrack : #{newTrack.title}"
                    res.status(201).send newTrack


module.exports.getAttachment = (req, res, next) ->
    TrackModel.find req.params.id, (err, trackFind) ->
        dataUpdate =
            lastPlay:   Date()
            plays:      trackFind.plays + 1
        # Update the last Play ans the number of plays
        trackFind.updateAttributes dataUpdate, (err) ->
            return next err if err
        # Create a stream
        stream = trackFind.getBinary "source", (err) ->
                return next err if err
        res.on 'close', ->
            console.log "stop stream"
        stream.pipe(res)


module.exports.delete = (req, res, next) ->
    TrackModel.find req.params.id, (err, trackFind) ->
        trackFind.destroy (err) ->
            return next err if err
        res.status(204).send {success: 'Track successfully deleted'}

module.exports.update = (req, res, next) ->
    delete req.body.state
    delete req.body.elem
    TrackModel.find req.params.id, (err, trackFind) ->
        return next err if err
        trackFind.updateAttributes req.body, (err) ->
            return next err if err
            res.status(200). send {success: 'Track successfully updated'}


module.exports.youtube = (req, res, next) ->
    url = "http://youtube.com/watch?v=#{req.params.url}"

    # Request for info on url Track
    client = request.newClient 'http://www.youtubeinmp3.com/'
    path = "/fetch/?api=advanced&format=JSON&video=#{encodeURI(url)}"
    client.get path, (err, result, videoInfo)->
        req.body.title = videoInfo.title
        path = "/fetch/?video=#{encodeURI(url)}"
        console.log path
        stream = client.saveFileAsStream path, (err, result, body) ->
            return err if err
        TrackModel.create req.body, (err, newTrack) =>
            return next err if err
            newTrack.attachBinary stream, {name: 'source'}, (err) ->
                return next err if err
                res.status(200).send newTrack
