# See documentation on https://github.com/cozy/cozy-db

cozydb = require 'cozydb'

module.exports =
    track_model:
        # shortcut for emit doc._id, doc
        all: cozydb.defaultRequests.all

        ## create all the requests you want!
        #customRequest:
            #map: (doc) ->
                ## map function
            #reduce: (key, values, rereduce) ->
                 ##non mandatory reduce function
    playlists_model:
        all: cozydb.defaultRequests.all
