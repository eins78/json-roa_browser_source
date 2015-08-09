uriTemplates = require('uri-templates')

uriTemplates.isTemplated = (url)->
  url != (try uriTemplates(url).fill({}))

module.exports = uriTemplates
