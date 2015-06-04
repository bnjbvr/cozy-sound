# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test.coffee                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/04 11:27:56 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/04 18:46:38 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

BaseView = require 'lib/base_view'
TestCollection = require 'collections/test'
TestModel = require 'models/test'
testProcessorModel = require 'models/test_processor'

module.exports = class TestView extends BaseView
    el: 'body.application'
    template: require('views/templates/test')

    initialize: ->
        @collection = new TestCollection()

    afterRender: ->
        @uploader = @$('#uploader')

    events: ->
        'change #uploader': 'onFilesChanged'

    onFilesChanged: (event) ->
        console.log "Change !"
        console.log @uploader[0].files
        console.log @uploader[0].files[0]
        @handleFiles @uploader[0].files

        ## reset the input
        #old = @uploader
        #@uploader = old.clone true
        #old.replaceWith @uploader
    handleFiles: (files) ->
        ## Set the view as dirty to warn users it will cancel the upload
        ## if he leaves the page during the upload.
        #app.router.mainView.dirty = true

        # Prepare common attributes for all pictures.
        #@options.beforeUpload (photoAttributes) =>
            @uploadCounter = 0

            # Add a photo to the collection, to avoid browser freezing,
            # after 20 pictures, it waits for 10ms (and release execution loop)
            # before adding pictures to the collection and the view.
            addPhotoAndBreath = (file, callback) =>
                test = @addTest file

                # When the first photo is uploaded, it is set as the album
                # cover.
                #if @uploadCounter is 0
                    #photo.on 'uploadComplete', =>
                        #@setCoverPicture photo

                if @uploadCounter > 20
                    setTimeout callback, 10
                else
                    @uploadCounter++
                    callback()

            ## Process all file creations
            async.eachSeries files, addPhotoAndBreath, =>

                ## save reference to the collection on each view.
                #view.collection = @collection for key, view of @views
                #app.router.mainView.dirty = false


    addTest: (file) =>
        test = new TestModel
            title: file.name
            size: file.size
            type: file.type
        test.file = file
        @collection.add test
        testProcessorModel.process test
        test

