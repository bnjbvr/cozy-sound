Playlist        = require '../models/playlist_model'

module.exports.all = (req, res) ->
    # Here we use the method all to retrieve all playlists stored.
    Playlist.all (err, playlists) ->
        if err
            #compound.logger.write err
            res.send 500, error: true, msg: "Server error occured while retrieving data."
        else
            res.send 200, playlists
