
cozydb = require 'cozydb'

module.exports = PlaylistModel = cozydb.getModel 'Playlist',
    title:     String
    dateAdded: {'type': Date, 'default': Date.now}
    lastPlay:  Date
    plays:     {'type': Number, 'default': 0}
