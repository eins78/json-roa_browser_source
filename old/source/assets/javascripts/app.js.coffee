#= require_tree ./_templates
#= require_tree ./_app


###############################################################################
# Initialize ##################################################################
###############################################################################


$ -> 

  window.logger = logger = Logger.create namespace: 'Main', level: 'debug'

  $("#nojs-alert").remove()

  $("#self-relation, #collection, #relations").hide()

  $("#response-headers-panel").hide()
  $("#response-json-data-panel, #response-json-roa-panel").hide()
  $("#response-text-panel, #response-content-panel").hide()


  url= URIjs(window.location.href).normalizeHash().fragment().trim()

  #headers= URIjs.parseQuery(URIjs(window.location.href).query())['headers'] || $("#headers").val() 


  #console.log url: url

  if url.length > 0
    $("#url").val(url)
    APP.BrowserState.pushOrReplaceState()
    APP.Request.get(url)

  $("#get").click (e) ->
    logger.debug onGetClick: e
    # get(null,updateHistory: true)
  
  $("#request-form").on "submit", (e)->
    logger.debug "onRequestFormSubmit", arguments
    e.preventDefault()
    APP.Request.get $("#url").val()
    false

  # TODO 
  # can we use 
  #
  # $(window).on('hashchange', function() {
  #
  # ????
  #   
