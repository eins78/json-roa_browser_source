# browser Model - browser.js
Model = require('ampersand-model')
parseHeaders = require('parse-headers')
xhr = require('xhr')

module.exports = Model.extend({
  props:
    requestUrl:
      type: 'string'
      default: 'https://json-roa-demo.herokuapp.com/'
      required: true
    requestHeaders:
      type: 'string'
      default: 'Accept: application/json-roa+json\n'
      required: false

  session:
    responseBody: 'object' # tmp

  # runs after 'create' (this = new instance with all attributes):
  initialize: () ->
    do @runRequest # run the initial request

  # instance methods:
  runRequest: ()->
    return unless @requestUrl
    xhr {
      url: @requestUrl
      method: 'GET'
      headers: parseHeaders(@requestHeaders)
    }, (err, res, body)=>
      @set('responseBody', res)
      # @response.set {err: err, res: res, body: body}
})
