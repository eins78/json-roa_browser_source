# lodash (like underscore) + mixins, used throughout app as `f`
f = require('lodash')

f.mixin({
  presence: (object)-> object unless f.isEmpty(object)
}, {chain: false})

module.exports = f
