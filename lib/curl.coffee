httpRequest = require('nets')
f = require('lodash')

module.exports = (opts, callback)->
  conf = f({})
    .merge(opts, {
      body: (try JSON.stringify(opts.body))
      headers: f.merge({}, opts.headers, 'Content-Type': opts.contentType)
    })
    .omit('contentType')
    .value()

  httpRequest conf, (err, res, body)->
    body = (try body.toString())
    body = (try JSON.parse(body)) or body
    callback?(err, f.assign({}, res, body: body, encoding: 'UTF-8'), body)
