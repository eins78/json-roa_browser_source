Model = require('ampersand-state')
f = require('lodash')

# NOTE: This model is not used directly;
# but it is the base for RoaRelation and RoaMetaRelation!

module.exports = Model.extend
  idAttribute: 'href'
  # > "A relation is an object which must contain the key href.
  #    It may contain the keys embedded, name, methods, and relations."
  props:
    id: 'string' # Relation Identifier, originally key of relation in relations
    href:
      type: 'string'
      required: true
      default: null
    embedded: 'string'
    name:
      type: 'string'
      # default: -> @id
    methods:
      type: 'object' # allowed keys 'get, put, patch, post, and delete'
      default: -> {get: {}}
