React = require('react')
Icon = require('../icon')

module.exports = React.createClass
  displayName: 'RunningPanel'
  render: ()->
    <div className='panel panel-warning'>
      <div className='panel-heading'>
        <h3>
          <Icon icon='circle-o-notch fa-spin'/> Running…
        </h3>
      </div>
    </div>
