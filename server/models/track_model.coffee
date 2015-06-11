
# See documentation on https://github.com/aenario/cozydb/

cozydb = require 'cozydb'

module.exports = TrackModel = cozydb.getModel 'Track',
    title:            type: String, default: ''
    artist:           type: String, default: ''
    album:            type: String, default: ''
    track:            type: String, default: ''
    size:             type: Number, default: 0
    year:             type: String, default: ''
    genre:            type: String, default: ''
    time:             type: String, default: ''
    playlistId:       type: [String]
    lastModified:     type: Date,   default: Date.now()
    dateAdded:        type: Date,   default: Date.now()
    lastPlay:         type: Date,   default: Date.now()
    binary:           Object
    plays:            type: Number, default: 0
    rating:           type: Number, default: 0 # Reserved
    bitRate:          type: Number, default: 0 # Reserved
    public:           type: Boolean,default: false # Reserved


