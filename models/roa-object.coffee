# roaResponse Model - roa-response.js
Model = require('ampersand-state')
f = require('lodash')

RoaRelations = require('./roa-relation-collection')

module.exports = Model.extend
  type: 'RoaObject'
  initialize: (data)->
    # map from object to array, using key as 'id'
    relations = f.map(data.relations, (val, key)-> f.assign(val, {id: key}))
    @relations = new RoaRelations(relations)

  props:
  # > "A minimal valid JSON-ROA extension must contain the key version
  #    where the value must be formatted according to Semantic Versioning."
    version:
      type: 'string' # TODO: add type semver
      require: true

  # > "It may further contain the keys
  #    relations, collection, name, and self-relation."
  children:
    relations: RoaRelations
    # collection: RoaCollection
    # name: RoaName
    # 'self-relation': RoaSelfRelation
