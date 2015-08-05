httpRequest = require('nets')
f = require('lodash')

module.exports = (opts, callback)->
  httpRequest opts, (err, res, body)->
    body = (try body.toString())
    body = (try JSON.parse(body)) or body
    callback?(err, f.assign(res, body: body), body)
