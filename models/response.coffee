Model = require('ampersand-state')
httpStatusText = require('node-status-codes')
f = require('../lib/fun')
stringifyHeaders = require('../lib/stringify-http-headers')

ROA_PROP = '_json-roa'

module.exports = Model.extend
  props:
    body: 'any'
    statusCode: 'number'
    method: 'string'
    headers: 'object'
    url: 'string'

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
      fn: ()-> f(this.body).pick(ROA_PROP).presence()
