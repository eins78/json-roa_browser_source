React = require('react')

module.exports = React.createClass
  # react methods:
  displayName: 'RequestConfig'

  # event handlers:
  onChangeUrl: (event) ->
    @props.onConfigChange(url: event.target.value)

  onChangeHeaders: (event) ->
    @props.onConfigChange(headers: event.target.value)

  render: ()->

    <div className='app--browser--request'>
      <h3>Request</h3>

      <form id="request-form" role="form" onSubmit={@props.onSubmit}>

        <div className="form-group">
          <label htmlFor="request-headers">Request Headers</label>
          <textarea className="form-control small"
            id="request-headers"
            onChange={@onChangeHeaders}
            value={@props.headers}/>
        </div>

        <div className="form-group">
          <div className="input-group">
            <input className="form-control small"
              id="url"
              type="text"
              value={@props.url}
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
