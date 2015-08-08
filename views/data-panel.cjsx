React = require('react')
Btn = require('react-bootstrap/lib/Button')
stringify = require('json-stringify-pretty-compact')

module.exports = React.createClass
  displayName: 'DataPanel'

  getInitialState: ()-> { open: null, expanded: false }
  onOpenClick: ()-> @setState(open: true)
  onCloseClick: ()-> @setState(open: false)
  onExpandClick: ()-> @setState(expanded: true)
  onCollapseClick: ()-> @setState(expanded: false)

  render: ()->
    {id, title, level, text, dataObj} = @props
    level ||= 'info'
    {open, expanded} = @state

    # panel is open according to state, or if not set then if data is present:
    open = if open? then open else (text? or dataObj?)

    width = 60

    # if no text given, stringify data
    # TODO: toggle raw view
    text ||= if dataObj? then (try stringify(dataObj, maxLength: width))
    text ||= '[No Data]'

    exandable = (text.split('\n').length > 20)

    itemClass = if open then '' else ' item-closed'
    preClass = if expanded then '' else 'pre-scrollable'

    openToggle = if open
      <Btn title='close' onClick={@onCloseClick}><i className='fa fa-chevron-up'/></Btn>
    else
      <Btn title='open' onClick={@onOpenClick}><i className='fa fa-chevron-down'/></Btn>

    expandToggle = if exandable
      if expanded
        <Btn title='collapse'onClick={@onCollapseClick} disabled={not open}>
          <i className='fa fa-compress'/></Btn>
      else
        <Btn title='expand'onClick={@onExpandClick} disabled={not open}>
          <i className='fa fa-expand'/></Btn>


    <li id={id} className={'list-group-item ' + itemClass}>
      <div className='list-group-item-heading'>
        <span onClick={open && @onCloseClick || @onOpenClick}>{title}</span>
        <div className="btn-group btn-group-xs pull-right" role="group">
          {expandToggle}
          {openToggle}
        </div>

      </div>
      {if open
        <div className='list-group-item-body'>
        <pre id={id} className={'source-code small ' + preClass}>
          {text}
        </pre>
        </div>
      }
    </li>
