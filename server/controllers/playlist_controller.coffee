# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    playlist_controller.coffee                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/10 13:27:58 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/10 21:05:46 by ppeltier         ###   ########.fr        #
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
    Playlist.destroy req.params.id, (err, playlist) ->
        return next err if err
        res.status(204).send {success: "Playlist successfuly removed"}

module.exports.add = (req, res, next) ->
    async.parallel ->
        Playlist.find req.params.playlistId, (err, playlist) ->
            return next err if err
            playlist.trackId.push req.params.id
            playlist.size = playlist.size + 1
            playlist.lastModified = Date.now
            playlist.updateAttributes playlist, (err) ->
                return next err if err
        Track.find req.params.id, (err, track) ->
            return next err if err
            track.playlists.push req.params.playlistId
            track.lastModified = Date.now
            track.updateAttributes track, (err) ->
                return next err if err
     res.status(201).send playlist



module.exports.get = (req, res, next) ->
    Playlist.find req.params.id, (err, playlist) ->
        return next err if err
        res.status(200).send playlist
