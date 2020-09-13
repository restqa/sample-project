const { Router } = require('express')
const { v4:uuidv4 } =  require('uuid')

module.exports = Router({ mergeParams: true })
  .use('/:id', (req, res, next) => {
    let err
    req.user = $.cache.get(req.params.id)
    if (!req.user) {
      let err = new Error(`The user ${req.params.userId} doesn't exist`)
      err.status = 404
    }
    next(err)
  })
  .post('/', (req, res, next) => {
    let { body } = req
    body = {
      id: uuidv4(),
      ...body
    }

    if (!body.firstname) {
      let err = new Error('firstname is mandatory')
      err.status = 406
      return next(err)
    }

    if (!body.lastname) {
      let err = new Error('lastname is mandatory')
      err.status = 406
      return next(err)
    }

    success = $.cache.set(body.id, body)
    res.json(body)
  })
  .get('/', (req, res) => {
    let mykeys = $.cache.keys()
    res.json(Object.values($.cache.mget(mykeys)))
  })
  .get('/:id', (req, res, next) => {
    res.json(req.user)
  })
  .put('/:id', (req, res, next) => {
    let { body } = req

    if (!body.firstname) return next({code: 406, msg: 'firstname is mandatory'})
    if (!body.lastname) return next({code: 406, msg: 'lastname is mandatory'})

    $.cache.set(body.id, body)
    res.json(body)
  })
  .delete('/:id', (req, res, next) => {
    $.cache.del(req.user.id)
    res.sendStatus(204)
  })
