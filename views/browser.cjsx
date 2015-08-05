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

  onRequestSubmit: (event)-> # save config, then run request:
    event.preventDefault()
    @props.browser.save()
    @props.browser.runRequest()

  onClear: ()-> @props.browser.clear()

  render: ()->
    browser = @props.browser

    <div className='app--browser row'>

      <div className='col-md-7'>
        <RequestConfig
          config={browser.requestConfig}
          onSubmit={@onRequestSubmit}
          onClear={@onClear}
          onConfigChange={@onRequestConfigChange}/>
      </div>

      <div className='col-md-5'>
        <ResponseInfo
          response={browser.response}/>
      </div>
    </div>
