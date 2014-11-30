###############################################################################
# URL #########################################################################
###############################################################################

$ -> 

  logger= Logger.create namespace: 'APP.URL', level: 'info'

  nullifyIfEmpty= (s)->
    if s.trim() ==  ""
      null
    else
      s

  # TODO try catch

  urlExpansionData= null
  $("#url-expansion-modal form").on 'submit', (e)->
    try
      e.preventDefault()
      $("#url-expansion-modal").modal('hide')
      urlSettings= JSON.parse($(e.target).find("textarea").val())
      url= window['URI-Templates'](urlExpansionData.url).fillFromObject(urlSettings)
      urlExpansionData.cont url
    catch e
      logger.error e
      $("#error-modal .modal-body pre").html e.stack.toString()
      $("#error-modal").modal({})
      throw e



  amend= (url)->
    logger.debug "amend", arguments
    targetUri=URIjs(url)
    currentUri= URIjs(window.location.hash.substring(1))
    hostname= nullifyIfEmpty(targetUri.hostname()) || currentUri.hostname()
    port= nullifyIfEmpty(targetUri.port()) || currentUri.port()
    protocol= nullifyIfEmpty(targetUri.protocol()) || currentUri.protocol()
    targetUri.hostname(hostname).port(port).protocol(protocol).normalize().href()

  buildTemplated= (url,cont)->
    logger.debug "buildTemplated", arguments
    templateVars= _.chain(window['URI-Templates'](url).varNames) \
      .map((name)-> ["#{name}", null]).object().value()
    urlExpansionData={url: url, cont: cont}
    $("#templated-url").html url
    $("#url-parameters-input").val FormatJson.plain(templateVars)
    $("#url-expansion-modal").modal({})


  isTemplated= (url)-> 
    URITemplate(url).expand({}) != url

  build= (url,cont)->
    logger.debug "build", arguments
    _cont= (url)-> cont(amend(url))
    if isTemplated url
      buildTemplated url, _cont
    else
      _cont(url)

  window.APP ||= {}
  window.APP.URL=
    isTemplated: isTemplated
    build: build
    amend: amend

