React = require('react')
Btn = require('react-bootstrap/lib/Button')
ampersandReactMixin = require 'ampersand-react-mixin'
f = require('../../lib/fun')

module.exports = React.createClass
  # react methods:
  displayName: 'RequestConfig'
  mixins: [ampersandReactMixin]

  # event handlers:
  onClearClick: (_event) -> @props.onClear()

  updateConfigKey: (key, event) ->
    @props.onConfigChange(key, event.target.value)

  render: ()->
    conf = @props.config
    SHOW_BASIC_AUTH = false # TMP, does only make sense in special cases.

    <div className='app--browser--request panel panel-default'>
      <div className='panel-heading'>
        <h3>Request
          <div className="btn-group btn-group-xs pull-right" role="group">
            <Btn title='reset' onClick={@onClearClick}>
              <i className='fa fa-trash'/></Btn>
          </div>
        </h3>
      </div>

      <form id="request-form" role="form" onSubmit={@props.onSubmit}>

        <div className='panel-body'>
        <div className='row'>

          <div className={SHOW_BASIC_AUTH && 'col-md-7' || 'col-md-12'}>
          <div className="form-group">
            <label htmlhtmlFor="request-headers">HTTP Headers</label>
            <textarea className="form-control small"
              id="request-headers"
              rows='3'
              value={conf.headers}
              onChange={f.curry(@updateConfigKey)('headers')}/>
          </div>
          </div>

          {SHOW_BASIC_AUTH &&
            <div className='col-md-5'>
              <div className="form-group">
                <label>Basic Authentication</label>

                <div className='form-horizontal'>
                  <div className="form-group form-group-sm">
                    <label htmlFor="exampleInputName2" className='col-sm-2'>user</label>
                    <div className='col-sm-10'>
                    <input type="text" className="form-control"
                      id="exampleInputName2" placeholder="Username"
                      value={conf.user}
                      onChange={f.curry(@updateConfigKey)('user')}/>
                    </div>
                  </div>
                  <div className="form-group form-group-sm">
                    <label htmlFor="exampleInputName2" className='col-sm-2'>pass</label>
                    <div className='col-sm-10'>
                    <input type="password" className="form-control"
                      id="exampleInputName2" placeholder="Password"
                      value={conf.pass}
                      onChange={f.curry(@updateConfigKey)('pass')}/>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          }
        </div>
        </div>

        <div className='panel-footer'>
        <div className="form-group">
          <div className="input-group">
            <input className="form-control small"
              id="url"
              type="text"
              value={conf.url}
              onChange={f.curry(@updateConfigKey)('url')}
              placeholder="Enter the URL of a JSON-ROA enabled API here!"/>
            <span className="input-group-btn">
              <button className="btn btn-success" id="get" type="submit">
                <samp>GET</samp>
              </button>
            </span>
          </div>
        </div>
        </div>

      </form>
    </div>
