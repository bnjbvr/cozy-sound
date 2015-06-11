Playlist = require '../models/playlist'

    # This class is a collection of Playlist wiche contain all tracks in a array
module.exports = class PlaylistsCollection extends Backbone.Collection

    # Model that will be contained inside the collection.
    model: Playlist

    # This is where ajax requests the backend.
    url: 'playlists'
