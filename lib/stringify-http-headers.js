var f = require('lodash')

var upcaseParts = function (string, divider) {
  if (typeof string !== 'string') return string

  return f.map(string.split(divider), function (part) {
      return f.capitalize(part)
    }).join(divider)
}

module.exports = function (headersObj) {
  if (typeof headersObj !== 'object') return

  return f(headersObj).map(function (val, key) {
      return [upcaseParts(key, '-'), val]
    }).reduce(function (result, line) {
      return result + line[0] + ': ' + line[1] + '\r\n'
    }, '')
}
