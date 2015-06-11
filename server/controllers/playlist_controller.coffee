# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    playlist_controller.coffee                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/10 13:27:58 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/11 20:00:19 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

Playlist        = require '../models/playlists_model'
Track           = require '../models/track_model'
async           = require 'async'

module.exports.all = (req, res, next) ->
    #Here we use the method all to retrieve all playlists stored.
    Playlist.all (err, playlists) ->
        return next err if err
        res.status(200).send playlists

module.exports.create = (req, res, next) ->
    Playlist.create req.body, (err, playlist) ->
        return next err if err
        res.status(201).send playlist

module.exports.delete = (req, res, next) ->
    Playlist.find req.params.id, (err, playlist) ->
        return next err if err
        for trackId in playlist.trackId
            Track.find trackId, (err, track) ->
                return next err if err
                for id, index in track.playlistId
                    if id == playlist.id
                        track.playlistId.splice index, index + 1
                        track.updateAttributes track, (err) ->
                            return next err if err
        playlist.destroy (err) ->
            return next err if err
            res.status(204).send {success: "Playlist successfuly removed"}

module.exports.add = (req, res, next) ->
    async.parallel [
        (cb) -> Playlist.find req.params.playlistId, (err, playlist) ->
            return next err if err
            playlist.trackId.push req.params.id
            playlist.size = playlist.size + 1
            playlist.lastModified = Date.now
            playlist.updateAttributes playlist, (err) ->
                return next err if err
                cb
        (cb) -> Track.find req.params.id, (err, track) ->
            return next err if err
            track.playlistId.push req.params.playlistId
            track.lastModified = Date.now
            track.updateAttributes track, (err) ->
                return next err if err
                cb
        ], (err, result) ->
        res.status(201)


module.exports.get = (req, res, next) ->
    Playlist.find req.params.id, (err, playlist) ->
        return next err if err
        res.status(200).send playlist
