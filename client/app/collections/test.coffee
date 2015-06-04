# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    test.coffee                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ppeltier <ppeltier@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/04 12:18:07 by ppeltier          #+#    #+#              #
#    Updated: 2015/06/04 12:36:52 by ppeltier         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

TestModel = require 'models/test'

module.exports = class TestCollection extends Backbone.Collection

    model: TestModel
