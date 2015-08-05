React = require('react')

module.exports = React.createClass
  displayName: 'DataPanel'

  render: ()->
    {id, title, level, dataObj} = @props
    level ||= 'info'

    text = (try JSON.stringify(dataObj, 0, 2)) if dataObj?
    text ||= '[NO DATA]'

    <div id={id + '-panel'} className={'panel panel-thick panel-' + level}>
      <div className='panel-heading'>{title}</div>
      <pre id={id} className='panel-body source-code small pre-scrollable'>
        {text}
      </pre>
    </div>
