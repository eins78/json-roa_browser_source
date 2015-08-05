# browser Model - browser.js
Model = require('ampersand-state')
parseHeaders = require('parse-headers')
hashchange = require('hashchange')
urlQuery = require('qs')
curl = require('../lib/curl')

RequestConfig = require('./request-config')

module.exports = Model.extend({
  # props: NOTE: the browser has no 'props', only children, session and methods.

  # children: nested state; NOTE: instances are never swapped out, only changed!
  children:
    requestConfig: RequestConfig

  # properties that are only local (never serialized)
  # NOTE: When type=state, instances will be swapped out regularly (and change!)
  session:
    responseBody: 'object' # TMP

  # run on 'create' when option parse=true
  parse: (data) ->
    # takes request config as a query-string (typically from url hash)
    if typeof data is 'string'
      return {requestConfig: (try urlQuery.parse(data))}

  # runs after 'create' (this = new instance with all attributes):
  initialize: () ->
    do @runRequest # run the initial request

  # instance methods:
  save: ()->
    hashchange.updateHash(urlQuery.stringify(@requestConfig.toJSON()))

  runRequest: ()->
    # NOTE: save config to browser history whenever a request is executed!
    do @save
    opts = {
      method: 'GET'
      url: @requestConfig.url
      headers: parseHeaders(@requestConfig.headers)
    }
    curl opts, (err, res, body)=>
      @set('responseBody', raw)
      # @response.set {err: err, res: res, body: body}
})
