React = require('react')
ampersandReactMixin = require 'ampersand-react-mixin'

module.exports = React.createClass
  displayName: 'ResponseInfo'
  displayName: 'ApiBrowser'

  mixins: [ampersandReactMixin]

  render: ()->
    response = @props.response

    content = if response?
      <pre>
        {JSON.stringify(response, 0, 2)}
      </pre>
    else
       <span>No Response yet…</span>

    <div className='app--browser--response'>
      <h3>Response RAW</h3>
      {content}
    </div>
