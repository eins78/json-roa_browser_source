app = require('ampersand-app')
React = require('react')

AppView = require('./views/app')
Browser = require('./models/browser')

# add css to output:
require('./style.less')

app.extend
  browser: new Browser()
  # TODO: loggger: ???

  init: ()->
    # TODO: apply initial config from URL

    # init react view (auto-refreshes on model changes):
    React.render(<AppView app={app}/>, document.body)

# attach to browser console for development
window.app = app

# kickoff
do app.init
