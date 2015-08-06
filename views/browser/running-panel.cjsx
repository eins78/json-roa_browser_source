React = require('react')

module.exports = React.createClass
  displayName: 'RunningPanel'
  render: ()->
    <div className='panel panel-warning'>
      <div className='panel-heading'>
        <h3>Running…</h3>
      </div>
    </div>
