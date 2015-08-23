React = require('react')
Modal = require('react-bootstrap/lib/Modal')
Button = require('react-bootstrap/lib/Button')

module.exports = React.createClass
  displayName: 'ActionForm'
  
  onClose: ()-> @props.onClose?()

  render: ()->
    {container} = @props

    # TODO: contain modal in browser, but open in middle of viewport…
    container = undefined

    <Modal show={true} onHide={@onClose}
      container={container}
      backdrop='static'>
      <Modal.Header closeButton>
        <Modal.Title>Modal heading</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <h4>Text in a modal</h4>
        <p>Duis mollis, est non commodo luctus, nisi erat porttitor ligula.</p>
      </Modal.Body>
      <Modal.Footer>
        <Button onClick={@onClose}>Close</Button>
      </Modal.Footer>
    </Modal>
