Model = require('ampersand-state')
httpStatusText = require('node-status-codes')
f = require('../lib/fun')
stringifyHeaders = require('../lib/stringify-http-headers')

RoaObject = require('./roa-object')

ROA_PROP = '_json-roa'

module.exports = Model.extend
  initialize: () ->
    @roaObject= new RoaObject(@jsonRoaRaw)

  props:
    body: 'any'
    statusCode: 'number'
    method: 'string'
    headers: 'object'
    url: 'string'
    # NOTE: in case of error only 'error' is set!
    error: 'string'

  children:
    roaObject: RoaObject

  derived:
    statusText:
      deps: ['statusCode'],
      fn: ()-> httpStatusText[@statusCode] or 'Unknown'

    headersText:
      deps: ['headers'],
      fn: ()-> f(stringifyHeaders(@headers), padding: true).presence()

    jsonRaw:
      deps: ['body']
      fn: ()-> f(this.body).omit(ROA_PROP).presence()

    jsonRoaRaw:
      deps: ['body']
      fn: ()-> f(this.body).get(ROA_PROP)
