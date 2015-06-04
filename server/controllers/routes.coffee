# See documentation on https://github.com/frankrousseau/americano#routes

track           = require './track_controller'
playlist        = require './playlist_controller'


test = require './test_controller'

module.exports =
    'tracks':
        get: track.all
        post: track.create

    #'playlists':
        #get: playlist.all

    'test':
        post: test.create
