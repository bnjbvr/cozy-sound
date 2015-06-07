
# See documentation on https://github.com/aenario/cozydb/

cozydb = require 'cozydb'

module.exports = TrackModel = new cozydb.getModel 'Track',

    title:            {'type': String, 'default': ''}
    artist:           {'type': String, 'default': ''}
    album:            {'type': String, 'default': ''}
    track:            {'type': String, 'default': ''}
    type:             {'type': String, 'default': ''}
    size:             {'type': Number, 'default': 0}
    year:             {'type': String, 'default': ''}
    genre:            {'type': String, 'default': ''}
    time:             {'type': String, 'default': ''}
    playlists:        Object
    dateAdded:        {'type': Date, 'default': Date()}
    lastPlay:         {'type': Date, 'default': Date()}
    binary:           Object
    plays:            {'type': Number, 'default': 0}
