Model = require('ampersand-state')
f = require('lodash')

RoaRelationBase = require('./_roa-relation-base')
RoaMetaRelations = require('./roa-meta-relation-collection')

module.exports = RoaRelationBase.extend
  type: 'RoaRelation'
  initialize: (data)->
    # map from object to array, using key as 'id'
    relations = f.map(data.relations, (val, key)-> f.assign(val, {id: key}))
    @relations = new RoaMetaRelations(relations, model: RoaRelationBase)

  children:
    relations: RoaMetaRelations
