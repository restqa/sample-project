const Express = require('express')
const Modules = require('./modules')

module.exports = Express()
  .use(Express.json())
  .use('/api-key', Modules.apikey)
  .use('/users', Modules.users)
  .use('/users/:userId/addresses', Modules.addresses)
  .use((err, req, res, next) => {
    $.log.error(err)
    res
      .status(err.status || 500)
      .json({
        message: err.message
      })
  })
