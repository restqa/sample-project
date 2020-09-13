const NodeCache = require("node-cache")

global.$ = {
  config: {
    port: process.env.PORT || 8080,
    apikey: process.env.API_KEY || 'd8ba0d75-76f8-47d4-8671-bfa2fbe4f5aa'
  },
  log: {
    info: console.log,
    error: console.log
  },
  cache: new NodeCache()
}

const http = require('http')
  .createServer(require('./server/app'))
  .listen($.config.port, () => {
    $.log.info('Running server on :' + $.config.port)
  })

process.on('SIGTERM', () => {
  $.log.info('Received SIGTERM. Exiting')
  http && http.close(() => process.exit(0))
})

process.on('uncaughtException', (err) => {
  $.log.info('Received uncaughtException. Exiting')
  $.log.info(err.stack)
  http && http.close(() => process.exit(1))
})
