React = require('react')
ampersandReactMixin = require 'ampersand-react-mixin'

module.exports = React.createClass
  displayName: 'RoaObject'
  mixins: [ampersandReactMixin]

  render: ()->
    {roaObject} = @props

    <div className='app--browser--roa-object'>
      <h3>ROA Resource</h3>

      <pre>{roaObject}</pre>
    </div>
