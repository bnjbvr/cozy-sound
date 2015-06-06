
# See documentation on https://github.com/aenario/cozydb/

cozydb = require 'cozydb'

module.exports = TrackModel = new cozydb.getModel 'Track',

    title:            String
    artist:           String
    album:            String
    track:            String
    type:             String
    size:             Number
    year:             String
    genre:            String
    time:             String
    slug:             String
    playlists:        Object
    dateAdded:        Date
    lastPlay:         Date
    binary:           Object
    plays:            Number
