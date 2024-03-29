// Generated by CoffeeScript 1.9.3
var broadcastInfo;

broadcastInfo = require('../models/broadcast_model');

module.exports.disable = function(req, res) {
  broadcastInfo.broadcastEnabled = false;
  return res.status(200).send({
    success: 'broadcast info successfully updated'
  });
};

module.exports.writeUrl = function(req, res) {
  if (broadcastInfo.broadcastEnabled && (broadcastInfo.lastPlayUrl != null)) {
    return res.status(200).send({
      url: broadcastInfo.lastPlayUrl,
      title: broadcastInfo.lastPlayTitle,
      artist: broadcastInfo.lastPlayArtist
    });
  } else {
    return res.status(200).send({
      error: 'Broadcast currently distabled'
    });
  }
};
