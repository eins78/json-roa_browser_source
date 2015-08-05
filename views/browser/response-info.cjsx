React = require('react')
ampersandReactMixin = require 'ampersand-react-mixin'
DataPanel = require('../data-panel')

module.exports = React.createClass
  displayName: 'ResponseInfo'
  mixins: [ampersandReactMixin]

  render: ()->
    response = @props.response
    level = 'success' # TODO: from response code
    panelClass = "panel panel-#{level}"
    labelClass = "label label-#{level}"
    fallback = <div/>

    return fallback unless response?

    <div className={'app--browser--response ' + panelClass}>
    
      <div className='response-status panel-heading'>
        <h3>Response <samp className={labelClass}>
          <strong>{response.statusCode}</strong> {statusText}</samp></h3>
      </div>

      <DataPanel title='Response RAW' level='info' dataObj={response}/>
      <DataPanel title='Headers' dataObj={null}/>
      <DataPanel title='JSON Data' dataObj={null}/>
      <DataPanel title='JSON-ROA Data' dataObj={null}/>

    </div>
