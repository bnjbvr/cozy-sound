# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test_controller.coffee                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/04 13:09:41 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/04 18:44:54 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

TrackModel = require '../models/track_model'

multiparty = require 'multiparty'
os = require 'os'
path = require 'path'


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
        uploadDir: path.join os.tmpdir(), 'uploads'
        defer: true # don't wait for full form. Needed for progress events
        keepExtensions: true
        maxFieldsSize: 100 * 1024 * 1024
    form.parse req

    # Get fields from form.
    form.on 'field', (name, value) ->
        console.log "field : #{value} / #{name}"
        req.body[name] = value
        if name is 'cid' then cid = value
        #else if name is 'albumid' and req.public
            #albumid = value
            #sharing.checkPermissionsPhoto {albumid}, 'w', req, (err, ok) ->
                #isAllowed = ok

    # Get files from form.
    form.on 'file', (name, val) ->
        console.log "get file : #{name} / #{val}"
        val.name = val.originalFilename
        val.type = val.headers['content-type'] or null
        files[name] = val

    # Get progress to display it to the user. Data are sent via websocket.
    form.on 'progress', (bytesReceived, bytesExpected) ->
        console.log "progress :"
        return unless cid?
        percent = bytesReceived/bytesExpected
        return unless percent - lastPercent > 0.05

        lastPercent = percent
        app.io.sockets.emit 'uploadprogress', cid: cid, p: percent

    form.on 'error', (err) ->
        return err if err.message isnt "Request aborted"

    # When form is fully parsed, data are saved into CouchDB.
    form.on 'close', ->
        console.log "close"
        req.files = qs.parse files
        raw = req.files['raw']

        console.log raw
        # cleanup & 401
        unless isAllowed
            cleanup()
            return next NotAllowed()


        #thumbHelpers.readMetadata raw.path, (err, metadata) ->
            #if err?
                #console.log "[Create photo - Exif metadata extraction]"
                #console.log "Are you sure imagemagick is installed ?"
                #next err
            #else
                ## Add date and orientation from EXIF data.
                #req.body.orientation = 1
                #if metadata?.exif?.orientation?
                    #orientation = metadata.exif.orientation
                    #req.body.orientation = \
                        #photoHelpers.getOrientation orientation

                #if metadata?.exif?.dateTime?
                    #req.body.date = metadata.exif.dateTime


            #photo = new Photo req.body
            track = new TrackModel



            console.log track

            TrackModel.create track, (err, track) ->
                return next err if err

            async.series [
                (cb) ->
                    raw = req.files['raw']
                    data = name: 'raw', type: raw.type
                    track.attachBinary raw.path, data, cb
            ], (err) ->
                cleanup()

            console.log track
            if err
                return next err
            else
                res.status(201).send photo
