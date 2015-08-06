React = require('react')
ampersandReactMixin = require 'ampersand-react-mixin'
Browser = require('./browser')

module.exports = React.createClass
  displayName: 'AppLayout'
  mixins: [ampersandReactMixin]

  render: ()->
    browser = @props.app.browser

    <div>
      <nav className="navbar navbar-default navbar-static-top">
        <div className="container-fluid">
           <div className="navbar-header">
            <h1>JSON-ROA Hypermedia API Browser</h1>
          </div>
        </div>
      </nav>
      <div className='app container-fluid'>
        <Browser browser={browser}/>
      </div>
    </div>
