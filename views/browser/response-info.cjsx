React = require('react')
ampersandReactMixin = require 'ampersand-react-mixin'
DataPanel = require('../data-panel')

module.exports = React.createClass
  displayName: 'ResponseInfo'
  mixins: [ampersandReactMixin]

  render: ()->
    {response} = @props

    level = if response.statusCode < 400 then 'success' else 'danger'
    panelClass = "panel panel-#{level}"
    labelClass = "label label-#{level}"

    <div className={'app--browser--response ' + panelClass}>

      <div className='response-status panel-heading'>
        <h3>Response <samp className={labelClass}>
          <strong>{response.statusCode}</strong> {response.statusText}</samp></h3>
      </div>

      <ul className="list-group">
        <DataPanel title='Headers'
            text={response.headersText} dataObj={response.headers}/>
        <DataPanel title='JSON Data' dataObj={response.jsonRaw}/>
        <DataPanel title='JSON-ROA Data' dataObj={response.jsonRoaRaw}/>
      </ul>
    </div>
