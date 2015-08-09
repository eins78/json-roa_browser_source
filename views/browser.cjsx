React = require('react')
ampersandReactMixin = require 'ampersand-react-mixin'
RequestConfig = require('./browser/request-config')
ResponseInfo = require('./browser/response-info')
ErrorPanel = require('./browser/error-panel')
RunningPanel = require('./browser/running-panel')
RoaObject = require('./browser/roa/roa-object')
DataPanel = require('./data-panel')

# API Browser UI –
module.exports = React.createClass
  displayName: 'ApiBrowser'
  mixins: [ampersandReactMixin]

  onRequestConfigChange: (key, value)->
    @props.browser.requestConfig.set(key, value)

  # when the main 'GET' button is clicked:
  onRequestSubmit: (event)-> # save config, then run request:
    event.preventDefault()
    @props.browser.save()
    @props.browser.runRequest()

  # when a Roa methods 'GET' button (untemplated) is clicked
  onMethodSubmit: (url)->
    console.log url
    @props.browser.requestConfig.url = url
    @props.browser.save()
    @props.browser.runRequest()

  onClear: ()-> @props.browser.clear()

  render: ()->
    browser = @props.browser

    <div className='app--browser row'>

      <div className='col-sm-7'>
        <RequestConfig
          config={browser.requestConfig}
          onSubmit={@onRequestSubmit}
          onClear={@onClear}
          onConfigChange={@onRequestConfigChange}/>

        {switch
          when (roaObject = browser.response?.roaObject)?
            <RoaObject roaObject={roaObject} onMethodSubmit={@onMethodSubmit}/>
          when (roaError = browser.response?.roaError)?
            <ErrorPanel title="ROA Error!"
              errorText={roaError}/>
        }
      </div>

      <div className='col-sm-5'>
        {switch
          when browser.response?.error?
            <ErrorPanel title='Request Error!'
              errorText={browser.response.error}/>
          when browser.response?
            <ResponseInfo response={browser.response}/>
          when browser.currentRequest?
            <RunningPanel/>
        }
      </div>
    </div>
