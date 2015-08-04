###############################################################################
# Response Handling ###########################################################
###############################################################################

$ -> 

  logger= Logger.create namespace: 'APP.Response', level: 'debug'

  clean= (requestId)->
    $("#response").attr("data-request-id",requestId)

    $("#response-status").empty()

    $("#iframe").attr "src", null
    $("#response-content-panel").hide()
  
    $("#response-headers").empty()
    $("#response-headers-panel").hide()

    $("#response-text").empty()
    $("#response-text-panel").hide()

    $("#response-json-data").empty()
    $("#response-json-data-panel").hide()

    $("#response-json-roa-data").empty()
    $("#response-json-roa-panel").hide()

  setResponseWaiting= (requestId)->
    window['APP']['JSON-ROA'].clean()
    clean(requestId)
    $("#response-status").html( JST['alert/warning']({message: JST['loading']({message: "Loading"})})) 

  setAlert= (jqXHR)->
    status= JST['jqXHR_status']({jqXHR: jqXHR})
    alert= 
      if 200 <= jqXHR.status < 300
        JST['alert/success']({message: status})
      else if 300 <= jqXHR.status < 600
        JST['alert/danger']({message: status})
      else 
        JST['alert/danger']({message: "<strong>ERROR</strong> See the browser logs for details."})
    $("#response-status").html(alert)

  setHeadersPanel= (jqXHR)->
    if 200 <= jqXHR.status < 600
      $("#response-headers").html jqXHR.getAllResponseHeaders()
      $("#response-headers-panel").show()
    else 
      $("#response-headers").empty()
      $("#response-headers-panel").hide()

  setTextPanel= (jqXHR)->
    if (200 <= jqXHR.status < 600 and 
        jqXHR.responseText? and jqXHR.responseText.trim() != "")
      $("#response-text").html jqXHR.responseText
      $("#response-text-panel").show()
    else 
      $("#response-text").empty()
      $("#response-text-panel").hide()


  setIframePanel= (jqXHR)->
    if  200 <= jqXHR.status < 300
      $("iframe").attr "src", jqXHR.url
      $("#open-content").attr "href", jqXHR.url
      $("#response-content-panel").show()

  setJsonDataPanel= (jqXHR)->
    if 200 <= jqXHR.status < 600 
      data= _.chain(jqXHR.responseJSON).pairs().reject( ([k,v])-> k == "_json-roa").object().value()
      $("#response-json-data").html FormatJson.plain(data)
      $("#response-json-data-panel").show()
    else
      $("#response-json-data").empty()
      $("#response-json-data-panel").hide()

  setJsonRoaDataPanel= (jqXHR)->
    if 200 <= jqXHR.status < 600 
      $("#response-json-roa").html FormatJson.plain(jqXHR.responseJSON['_json-roa'])
      $("#response-json-roa-panel").show()
    else
      $("#response-json-roa-data").empty()
      $("#response-json-roa-panel").hide()

  responseHanlder= (jqXHR)-> 
    logger.debug {jqXHR: jqXHR}
    jqXHR.headers= APP.Util.disectHeaders jqXHR.getAllResponseHeaders()
    contentType= jqXHR.headers['content-type'] || ""
    unless $("#response").attr("data-request-id") is jqXHR.requestId
      logger.warn "requestId #{jqXHR.requestId} conflict"
    else 
      clean()
      setAlert(jqXHR)
      setHeadersPanel(jqXHR)
      window['APP']['JSON-ROA'].renderAndShow(jqXHR)
      setTextPanel(jqXHR) if /text\/plain/.test(contentType)
      setIframePanel(jqXHR) unless  /json/.test(contentType) 
      setJsonDataPanel(jqXHR) if /json/.test(contentType)
      setJsonRoaDataPanel(jqXHR) if /json-roa/.test(contentType)


  window.APP ||= {}
  window.APP.Response=
    setResponseWaiting: setResponseWaiting
    responseHanlder: responseHanlder

