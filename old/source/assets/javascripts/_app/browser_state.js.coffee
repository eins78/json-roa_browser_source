###############################################################################
# BrowserState ################################################################
###############################################################################

$ -> 

  logger= Logger.create namespace: 'APP.BrowserState', level: 'info'

  pushOrReplaceState= (url,title)->
    logger.debug "pushOrReplaceState", arguments
    url||= URIjs(window.location.hash.substring(1)).normalize().readable()
    title||= url
    $("title").html( "JSON-ROA Browser : " + title)
    browserUrl= URIjs(window.location.href).hash(url).normalize().href()
    newState=url
    logger.debug "history.state", [history.state]
    if history.state == newState 
      logger.debug "replaceState", [newState, title, browserUrl]
      history.replaceState newState, title, browserUrl
    else
      logger.debug "pushState", [newState, title, browserUrl]
      history.pushState newState, title, browserUrl

  $(window).on 'hashchange', (e)->
    logger.debug "onHashchange", arguments 
    APP.Request.get URIjs(window.location.hash.substring(1)).normalize().href() 


  window.APP ||= {}
  window.APP.BrowserState=
    pushOrReplaceState: pushOrReplaceState

