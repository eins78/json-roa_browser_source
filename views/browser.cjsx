React = require('react')
ampersandReactMixin = require 'ampersand-react-mixin'
RequestForm = require('./browser/request-form')
ResponseInfo = require('./browser/response-info')

# API Browser UI –
module.exports = React.createClass
  displayName: 'ApiBrowser'
  mixins: [ampersandReactMixin]

  onRequestConfigChange: (config)->
    @props.browser.set('requestUrl', config.url) if config.url?
    @props.browser.set('requestHeaders', config.headers) if config.headers?

  onRequestSubmit: (event)->
    event.preventDefault()
    @props.browser.runRequest()

  render: ()->
    browser = @props.browser

    <div className='app--browser'>

      <RequestForm
        url={browser.requestUrl}
        headers={browser.requestHeaders}
        onSubmit={@onRequestSubmit}
        onConfigChange={@onRequestConfigChange}/>

      <ResponseInfo
        response={browser.responseBody}/>

    </div>
