app = require('ampersand-app')
React = require('react')
urlQuery = require('qs')
hashchange = require('hashchange')

AppView = require('./views/app')
Browser = require('./models/browser')

# add css to output:
require('./style.less')

app.extend
  init: ()->
    # init browser model, set initial config from URL
    @browser = new Browser(urlQuery.parse(window.location.hash.slice(1)))

    # update model whenever the url hash changes:
    hashchange.update (hashFragment)=>
      @browser.set(urlQuery.parse(hashFragment))

    # init react view (auto-refreshes on model changes):
    React.render(<AppView app={app}/>, document.body)

# attach to browser console for development
window.app = app

# kickoff
do app.init
