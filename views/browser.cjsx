React = require('react')
ampersandReactMixin = require 'ampersand-react-mixin'
RequestConfig = require('./browser/request-config')
ResponseInfo = require('./browser/response-info')

# API Browser UI –
module.exports = React.createClass
  displayName: 'ApiBrowser'
  mixins: [ampersandReactMixin]

  onRequestConfigChange: (config)->
    @props.browser.set('requestConfig', config)

  onRequestSubmit: (event)->
    event.preventDefault()
    @props.browser.runRequest()

  render: ()->
    browser = @props.browser

    <div className='app--browser row'>

      <div className='col-md-7'>
        <RequestConfig
          config={browser.requestConfig}
          onSubmit={@onRequestSubmit}
          onConfigChange={@onRequestConfigChange}/>
      </div>

      <div className='col-md-5'>
        <ResponseInfo
          response={browser.responseBody}/>
      </div>
    </div>
