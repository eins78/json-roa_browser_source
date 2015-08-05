# browser Model - browser.js
Model = require('ampersand-state')
parseHeaders = require('parse-headers')
hashchange = require('hashchange')
urlQuery = require('qs')
curl = require('../lib/curl')

RequestConfig = require('./request-config')
Response = require('./response')

module.exports = Model.extend({
  # props: NOTE: the browser has no 'props', only children, session and methods.

  # children: nested state; NOTE: instances are never swapped out, only changed!
  children:
    requestConfig: RequestConfig

  # properties that are only local (never serialized)
  # NOTE: When type=state, instances will be swapped out regularly (and change!)
  session:
    response: 'state'
    currentRequest: 'object'
    lastRequest: 'object'
    responseBody: 'object' # TMP

  # run on 'create' when option parse=true
  parse: (data) ->
    # takes request config as a query-string (typically from url hash)
    if typeof data is 'string'
      return {requestConfig: (try urlQuery.parse(data))}

  # instance methods:
  save: ()->
    hashchange.updateHash(urlQuery.stringify(@requestConfig.toJSON()))

  runRequest: ()->

    if @currentRequest?
      @currentRequest.abort()
      @currentRequest = null

    opts = {
      method: 'GET'
      url: @requestConfig.url
      headers: parseHeaders(@requestConfig.headers)
    }

    @currentRequest = curl opts, (err, res)=>
      @lastRequest = @currentRequest
      @currentRequest = null
      @response = new Response(res)
})
