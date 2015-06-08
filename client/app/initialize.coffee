# The function called from index.html
$ ->
    app = require 'application'
    require 'lib/app_helpers'

    $.ajax 'cozy-locale.json',
        success: (data) ->
            locale = data.locale
            initializeLocale(locale)
        error: ->
            initializeLocale(locale)

    initializeLocale = (locale) ->
        @locales = {}
        # if we don't find the appropiate locale file, it's English by default
        try
            @locales = require "locales/" + locale
        catch err
            @locales = require 'locales/en'

        @polyglot = new Polyglot()
        # we give polyglot the data
        @polyglot.extend @locales

        # handy shortcut
        window.t = @polyglot.t.bind @polyglot

        app.initialize()

