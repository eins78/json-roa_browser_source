React = require('react')
Btn = require('react-bootstrap/lib/Button')
Icon = require('react-bootstrap/lib/Glyphicon')
ampersandReactMixin = require 'ampersand-react-mixin'

module.exports = React.createClass
  # react methods:
  displayName: 'RequestConfig'
  mixins: [ampersandReactMixin]

  # event handlers:
  onChangeUrl: (event) ->
    @props.onConfigChange(url: event.target.value)
  onClearClick: (_event) -> @props.onClear()

  onChangeHeaders: (event) ->
    @props.onConfigChange(headers: event.target.value)

  render: ()->

    conf = @props.config

    <div className='app--browser--request'>
        <h3>Request
          <div className="btn-group btn-group-xs pull-right" role="group">
            <Btn title='reset' onClick={@onClearClick}>
              <Icon glyph='trash'/></Btn>
          </div>
        </h3>

      <form id="request-form" role="form" onSubmit={@props.onSubmit}>

        <div className='row'>

          <div className='col-md-7'>
          <div className="form-group">
            <label htmlhtmlFor="request-headers">Request Headers</label>
            <textarea className="form-control small"
              id="request-headers"
              rows='3'
              onChange={@onChangeHeaders}
              value={conf.headers}/>
          </div>
          </div>

          <div className='col-md-5'>
          <div className="form-group"      className='text-muted'     >
            <label>TODO: Basic Authentication</label>

            <div className='form-horizontal'>
              <div className="form-group form-group-sm">
                <label htmlFor="exampleInputName2" className='col-sm-2'>user</label>
                <div className='col-sm-10'>
                <input     disabled     type="text" className="form-control" id="exampleInputName2" placeholder="Username"/>
                </div>
              </div>
              <div className="form-group form-group-sm">
                <label htmlFor="exampleInputName2" className='col-sm-2'>pass</label>
                <div className='col-sm-10'>
                <input    disabled     type="password" className="form-control" id="exampleInputName2" placeholder="Password"/>
                </div>
              </div>
            </div>

          </div>
          </div>

        </div>

        <div className="form-group">
          <div className="input-group">
            <input className="form-control small"
              id="url"
              type="text"
              value={conf.url}
              onChange={@onChangeUrl}
              placeholder="Enter the URL of a JSON-ROA enabled API here!"/>
            <span className="input-group-btn">
              <button className="btn btn-primary" id="get" type="submit">
                GET
              </button>
            </span>
          </div>
        </div>

      </form>
    </div>
