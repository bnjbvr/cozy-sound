americano = require 'americano'

port = process.env.PORT || 9250
host = process.env.HOST || '127.0.0.1'

options =
    name: 'Sound'
    root: __dirname
    port: port
    host: host

americano.start options
