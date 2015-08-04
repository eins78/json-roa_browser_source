###############################################################################
# Util ########################################################################
###############################################################################

$ -> 

  logger= Logger.create namespace: 'APP.Util', level: 'debug'

  # headers ###################################################################
  #
  disectHeaders= (text)->
    _.chain(text.toLowerCase().split("\n")) \
      .map( (h)-> h.match(/([^:]+):(.+)/) ).filter( (p)-> p? ) \ 
      .map( (p)-> [p[1].trim(),p[2].trim()] ).object().value()


  # Confirm Modal #############################################################
  #
  confirmCont=null
  confirm= (renderedContent,cont)->
    confirmCont=cont
    $("#confirm-modal .modal-content").empty()
    $("#confirm-modal .modal-content").html renderedContent
    $("#confirm-modal").modal({})
  $("#confirm-modal").on 'submit', "form" , (e)->
    e.preventDefault()
    $("#confirm-modal").modal("hide")
    confirmCont()

  # ns ########################################################################
  #
  window.APP ||= {}
  window.APP.Util=
    confirm: confirm
    disectHeaders: disectHeaders



