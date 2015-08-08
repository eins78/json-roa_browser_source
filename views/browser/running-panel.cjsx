React = require('react')

module.exports = React.createClass
  displayName: 'RunningPanel'
  render: ()->
    <div className='panel panel-warning'>
      <div className='panel-heading'>
        <h3>
          <i className='fa fa-circle-o-notch fa-spin'/> Running…
        </h3>
      </div>
    </div>
