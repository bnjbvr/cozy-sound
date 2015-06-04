
# See documentation on https://github.com/aenario/cozydb/

cozydb = require 'cozydb'

module.exports = TrackModel = cozydb.getModel 'Track',
    title:     String
    artiste:   String
    album:     String
    track:     String
    year:      String
    genre:     String
    time:      String
    slug:      String
    playlists: Object
    dateAdded: {'type': Date, 'default': Date.now}
    lastPlay:  Date
    plays:     {'type': Number, 'default': 0}
