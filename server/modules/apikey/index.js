const { Router } = require('express')

function authentication (req, res, next) {
  let apikey = req.headers['x-api-key']
    || req.headers['api-key']
    || req.headers['apikey']
    || req.query['api-key']
    || req.query['x-api-key']
    || req.query['apikey']

  if (!apikey || $.config.apikey !== apikey) {
    let err = new Error('Invalid API KEY')
    err.status = 401
    return  next(err)
  }
  next()
}

module.exports = Router({ mergeParams: true })
  .use('/users/:userId/addresses', authentication, require('../addresses'))
  .use('/users', authentication, require('../users'))
