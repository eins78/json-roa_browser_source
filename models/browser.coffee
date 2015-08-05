# browser Model - browser.js
Model = require('ampersand-model')
parseHeaders = require('parse-headers')
curl = require('../lib/curl')
hashchange = require('hashchange')
urlQuery = require('qs')
RequestConfig = require('./request-config')

module.exports = Model.extend({

  children:
    requestConfig: RequestConfig

  session:
    responseBody: 'object' # tmp

  # runs after 'create' (this = new instance with all attributes):
  initialize: () ->
    do @runRequest # run the initial request

  # instance methods:
  saveConfigToUrl: ()->
    hashchange.updateHash(urlQuery.stringify(@requestConfig.toJSON()))

  runRequest: ()->
    do @saveConfigToUrl
    opts = {
      method: 'GET'
      url: @requestConfig.url
      headers: parseHeaders(@requestConfig.headers)
    }
    curl opts, (err, res, body)=>
      @set('responseBody', raw)
      # @response.set {err: err, res: res, body: body}
})
