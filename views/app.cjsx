React = require('react')
ampersandReactMixin = require 'ampersand-react-mixin'
Browser = require('./browser')

module.exports = React.createClass
  displayName: 'AppLayout'
  mixins: [ampersandReactMixin]

  render: ()->
    browser = @props.app.browser

    <div className='app container-fluid'>
      <h1>JSON-ROA Browser</h1>
      <Browser browser={browser}/>
    </div>
