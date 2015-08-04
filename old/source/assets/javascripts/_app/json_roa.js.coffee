###############################################################################
# JSON-ROA ####################################################################
###############################################################################

$ -> 

  logger= Logger.create namespace: 'APP.JSON-ROA', level: 'info'

  # Clean and Hide ############################################################

  clean= ()->
    logger.debug "clean", arguments
    $(".resource-name").empty()

    $("#self-relation tbody").empty()
    $("#self-relation").hide()

    $("#relations tbody").empty()
    $("#relations").hide()

    $("#collection tbody").empty()
    $("#collection").hide()
    $("#next").hide()


  # Render and Show ###########################################################

  renderRelationRow= (rel, relName)->
    JST['relation/row']({
      relName: relName
      title: rel.name 
      href: rel.href  
      methods: (rel.methods || {get: {}})
      metaRelations: (rel.relations || {})
    })

  showName= (jsonRoaData)->
    jsonRoaData.name? and $("#resource-name").html jsonRoaData.name

  showSelfRelation= (jsonRoaData)->
    if (self = jsonRoaData['self-relation']) and self?
      $("#self-relation tbody").append \
        renderRelationRow(self,(jsonRoaData.name || "self"))
      $("#self-relation").show()

  showRelations= (jsonRoaData)->
    if (relations= jsonRoaData.relations) and relations?
      _.each relations, (rel,k,obj)->
        $("#relations tbody").append renderRelationRow(rel,k)
      $("#relations").show()

  showCollection= (jsonRoaData)->
    if (collection= jsonRoaData.collection) and collection? 

      if (next= collection.next) and next?
        $("#next").attr "href", next.href
        $("#next").show()

      if (relations= collection.relations) and relations?
        _.each relations, (rel,k,obj)->
          $("#collection tbody").append renderRelationRow(rel,k)
        $("#collection").show()

  renderAndShow= (jqXHR)->
    if( 200 <= jqXHR.status < 600 and 
        /json-roa/.test(jqXHR.getResponseHeader("content-type")) )

      if (jsonRoaData= jqXHR.responseJSON['_json-roa']) and jsonRoaData?
        showName(jsonRoaData)
        showSelfRelation(jsonRoaData)
        showRelations(jsonRoaData)
        showCollection(jsonRoaData)


  # Handle Events #############################################################

  followLinkOfTarget= (e)->
    e.preventDefault()
    href= $(e.currentTarget).attr("href")
    APP.URL.build $(e.currentTarget).attr("href"), APP.Request.get

  deleteLinkOfTarget= (e)->
    e.preventDefault()
    APP.URL.build $(e.currentTarget).attr("href"), ((url)-> 
      confirmRendered= JST['request/confirm_delete']({url: url})
      APP.Util.confirm(confirmRendered, (()-> APP.Request.del url)))

  postPutLinkOfTarget= (e,method)->
    e.preventDefault()
    APP.URL.build $(e.currentTarget).attr("href"), ((url)-> 
      APP.Request.postPutModal(url,method))


  $("#collection").on 'click', "a#next", (e)->
    followLinkOfTarget e

  $("#self-relation, #collection, #relations").on 'click', "a.relation", (e)->
    switch $(e.currentTarget).attr("data-method")
      when "delete" 
        deleteLinkOfTarget e 
      when "put"
        postPutLinkOfTarget e, 'PUT'
      when "post"
        postPutLinkOfTarget e, 'POST'
      else 
        followLinkOfTarget e


  # Namespace #################################################################
 
  window.APP ||= {}
  window['APP']['JSON-ROA']=
    clean: clean
    renderAndShow: renderAndShow

