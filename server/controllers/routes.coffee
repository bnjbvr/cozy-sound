# See documentation on https://github.com/frankrousseau/americano#routes

track  = require './track_controller'

module.exports =
    'tracks':
        get: track.all
