const express = require('express')
const NodeCache = require("node-cache")
const { v4:uuidv4 } =  require('uuid')

const Cache = new NodeCache()
let { PORT } = process.env
PORT = PORT || 8080

express()
  .use(require('body-parser').json())
  .use('/users/:id', (req, res, next) => {
    let err
    req.user = Cache.get(req.params.id)
    if (!req.user) {
      err = {code: 404, msg: `user not found`}
    }
    next(err)
  })
  .post('/users', (req, res, next) => {
    let { body } = req
    body = {
      id: uuidv4(),
      ...body
    }

    if (!body.firstname) return next({code: 406, msg: 'firstname is mandatory'})
    if (!body.lastname) return next({code: 406, msg: 'lastname is mandatory'})

    success = Cache.set(body.id, body)
    res.json(body)
  })
  .get('/users', (req, res) => {
    let mykeys = Cache.keys()
    res.json(Object.values(Cache.mget(mykeys)))
  })
  .get('/users/:id', (req, res, next) => {
    res.json(req.user)
  })
  .put('/users/:id', (req, res, next) => {
    let { body } = req

    if (!body.firstname) return next({code: 406, msg: 'firstname is mandatory'})
    if (!body.lastname) return next({code: 406, msg: 'lastname is mandatory'})

    Cache.set(body.id, body)
    res.json(body)
  })
  .delete('/users/:id', (req, res, next) => {
    Cache.del(req.user.id)
    res.sendStatus(204)
  })
  .use((err, req, res, next) => {
    res.status(err.code).json(err)
  })
  .listen(PORT, () => console.log('start server on ' + PORT))
