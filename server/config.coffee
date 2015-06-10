americano = require 'americano'
config =
    common: [
        require('cozy-i18n-helper').middleware
        americano.bodyParser()
        americano.methodOverride()
        americano.errorHandler
            dumpExceptions: true
            showStack: true
        americano.static __dirname + '/../client/public',
            maxAge: 86400000
    ]

    development: [
        americano.logger 'dev'
    ]

    production: [
        americano.logger 'short'
    ]

    plugins: [
        'cozydb'
    ]

module.exports = config
