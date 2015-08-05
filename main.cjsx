app = require('ampersand-app')
React = require('react')
urlQuery = require('qs')
hashchange = require('hashchange')

AppView = require('./views/app')
Browser = require('./models/browser')

# add css to output:
require('./styles.less')

app.extend
  init: ()->
    # init browser model, sets initial config from URL hash fragment:
    @browser = new Browser(window.location.hash.slice(1), parse: true)

    # whenever the url hash changes, update model and run the request:
    hashchange.update (hashFragment)=>
      @browser.set(requestConfig: urlQuery.parse(hashFragment))
      @browser.runRequest()

    # init react view (auto-refreshes on model changes):
    React.render(<AppView app={app}/>, document.body)

    # run the initial request on startup
    do @browser.runRequest

# attach to browser console for development
window.app = app

# kickoff
do app.init
