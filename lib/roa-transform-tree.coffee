f = require('./fun')

# For the root object itself, and all properties of the root object which
# can have a `relations` key, recursivly transform those hashes to arrays.
module.exports = (data)->
  f.merge {}, transformRoaRelations(data),
    collection: transformRoaRelations(data?.collection)
    'self-relation': if (self=data?['self-relation'])?
      f.set(transformRoaRelations(self), 'keyName', 'self-relation')


transformRoaRelations = (data)->
  return data unless typeof data?.relations is 'object'
  f.merge {}, data,
    relations: hashToArrayWithKey(data.relations).map (item)->
      transformRoaRelations(item)

hashToArrayWithKey = (object)->
  f.map(object, (val, key)-> f.assign(val, f.set({}, 'keyName', key)))
