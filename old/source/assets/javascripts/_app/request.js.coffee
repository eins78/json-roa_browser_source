###############################################################################
# Request #####################################################################
###############################################################################

$ -> 

  logger= Logger.create namespace: 'APP.Request', level: 'debug'


  # ajax ########################################################################

  ajax= (url,method,contentType,data)->
    logger.debug "ajax", arguments

    requestId= Math.random().toString()
    APP.Response.setResponseWaiting(requestId)

    req=
      url: url
      headers: APP.Util.disectHeaders($("#request-headers").val())
      beforeSend: (jqXHR,settings)->
        jqXHR.url= url
        jqXHR.requestId= requestId
      xhrFields: 
        withCredentials: true
      type: method ? 'get'
      contentType: contentType ? "text/plain"
      data: data
      processData: false

    $.ajax(req) \
      .done((_1,_2,jqXHR)-> APP.Response.responseHanlder(jqXHR)) \
      .fail((jqXHR)-> APP.Response.responseHanlder(jqXHR)) \
      .always(APP.BrowserState.pushOrReplaceState(url))



  # GET #########################################################################

  get= (url)->
    logger.debug "get", {url: url}
    ajax(url,'get')

  # DEL(ETE) ####################################################################

  del= (url)->
    logger.debug "del", {url: url}
    ajax(url,'delete')


  # POST PUT ####################################################################
  
  postPutData= null
  postPutModal= (url,method)->
    postPutData= 
      url: url
      method: method
    logger.debug "postPutModal", arguments
    $("#post-put-modal button[type=submit]").html(method.toUpperCase())
    $("#post-put-modal .url").html(url)
    $("#post-put-modal").modal({})


  $("#post-put-modal form").on "submit", (e)->
    e.preventDefault()
    $("#post-put-modal").modal('hide')
    ajax(
      postPutData.url,
      postPutData.method,
      $("#post-put-modal .content-type").val(),
      $("#post-put-modal .content").val())
      

  # #############################################################################

  window.APP ||= {}
  window.APP.Request=
    get: get
    del: del
    postPutModal: postPutModal
