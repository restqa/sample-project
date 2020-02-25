const express = require('express')
const NodeCache = require("node-cache")
const { v4:uuidv4 } =  require('uuid')
const unirest = require('unirest')

const Cache = new NodeCache()
let { PORT, URL_USER_SVC } = process.env

PORT = PORT || 8080
URL_USER_SVC = URL_USER_SVC || 'http://host.docker.internal:7676'

function checkUser(req, res, next) {
  unirest
    .get(`${URL_USER_SVC}/users/${req.params.userId}`)
    .then(result => {
      if (result.ok) {
        req.user = result.body
        next()
      } else {
        next(result.body)
      }
    })
}

express()
  .use(require('body-parser').json())
  .use('/users/:userId/addresses', checkUser)
  .post('/users/:userId/addresses', (req, res, next) => {
    let { body } = req
    body = {
      id: uuidv4(),
      ...body
    }

    if (!body.street) return next({code: 406, msg: 'street is mandatory'})
    if (!body.zipcode) return next({code: 406, msg: 'zipcode is mandatory'})
    if (!body.city) return next({code: 406, msg: 'city is mandatory'})

    body.user = {
      id: req.user.id
    }
    Cache.set(body.id, body)
    res.json(body)
  })
  .get('/users/:userId/addresses', (req, res) => {
    let mykeys = Cache.keys()
    result = Object.values(Cache.mget(mykeys)).filter(item => req.user.id === item.user.id) // filter on the current user
    res.json(result)
  })
  .use('/users/:userId/addresses/:id', checkUser, (req, res, next) => {
    let err
    req.address = Cache.get(req.params.id)
    if (!req.address) {
      err = {code: 404, msg: `address not found`}
    } else {
      if (req.address.user.id !== req.user.id) {
        err = {code: 403, msg: `not allowed`}
      }
    }
    next(err)
  })
  .get('/users/:userId/addresses/:id', (req, res, next) => {
    res.json(req.address)
  })
  .put('/users/:userId/addresses/:id', (req, res, next) => {
    let { body } = req

    if (!body.street) return next({code: 406, msg: 'street is mandatory'})
    if (!body.zipcode) return next({code: 406, msg: 'zipcode is mandatory'})
    if (!body.city) return next({code: 406, msg: 'city is mandatory'})

    Cache.set(body.id, body)
    res.json(body)
  })
  .delete('/users/:userId/addresses/:id', (req, res, next) => {
    Cache.del(req.address.id)
    res.sendStatus(204)
  })
  .use((err, req, res, next) => {
    res.status(err.code).json(err)
  })
  .listen(PORT, () => console.log('start server on ' + PORT))
