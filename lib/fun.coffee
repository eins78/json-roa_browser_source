# lodash (like underscore) + mixins, used throughout app as `f`
f = require('lodash')

f.mixin {
  presence: (object)-> f(object).value() unless f.isEmpty(object)

  # return object with keys sorted like word in array, extra keys at the end.
  sortKeysLike: (obj, keys)->
    f(keys).map((k)-> if (v=f(obj).get(k))? then [k,v]).filter().zipObject()
      .merge(obj).value()

}, {chain: false} # returns value if chained (without needing to call it)

module.exports = f
