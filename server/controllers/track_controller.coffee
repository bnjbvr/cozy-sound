# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_controller.coffee                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/04 13:09:41 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/05 20:45:03 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

TrackModel = require '../models/track_model'
multiparty = require 'multiparty'
os         = require 'os'
path       = require 'path'


module.exports.all = (req, res) ->
    TrackModel.request 'all', (err, data) ->
        if err
            res.status(500).send({error: "An error has occured -- #{err}"})
        else
            res.send(data)


module.exports.create = (req, res) ->
    console.log "create file"
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
        return err if err.message isnt "Request aborted"

    # When form is fully parsed, data are saved into CouchDB.

    form.parse req, (err, fields, files) ->
        console.log "data"
        file =  files.file[0]
        console.log "sixe"
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
            console.log data
            data = name: 'souce'
            newTrack.attachBinary files.file[0].path, data, (err) ->
                if err
                    console.log err
                else
                    299
