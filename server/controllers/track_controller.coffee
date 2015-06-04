# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    track_controller.coffee                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/03 12:44:28 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/04 15:14:46 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

TrackModel   = require '../models/track_model'

module.exports.all = (req, res) ->
    # Here we use the method all to retrieve all tracks stored.
    TrackModel.all (err, tracks) ->
        if err
            res.send 500, error: true
            msg: "Server error occured while retrieving data."
        else
            res.send 200, tracks

module.exports.create = (req, res) ->
    console.log "create file"
    cid = null
    lastPercent = 0
    files = {}
    isAllowed = not req.public

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
        maxFieldsSize: 10 * 1024 * 1024
    form.parse req
