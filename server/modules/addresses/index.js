const { Router } = require('express')
const { v4:uuidv4 } =  require('uuid')

function checkUser(req, res, next) {
   req.user = $.cache.get(req.params.userId)
   if (!req.user) {
     let err = new Error(`The user ${req.params.userId} doesn't exist`)
     err.status = 404
     return next(err)
   }
   next()
}

module.exports = Router({ mergeParams: true })
  .use('/', checkUser)
  .post('/', (req, res, next) => {
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
    $.cache.set(body.id, body)
    res.json(body)
  })
  .get('/', (req, res) => {
    let mykeys = $.cache.keys()
    result = Object.values($.cache.mget(mykeys)).filter(item => req.user.id === item.user.id) // filter on the current user
    res.json(result)
  })
  .use('/:id', checkUser, (req, res, next) => {
    let err
    req.address = $.cache.get(req.params.id)
    if (!req.address) {
      err = {code: 404, msg: `address not found`}
    } else {
      if (req.address.user.id !== req.user.id) {
        err = {code: 403, msg: `not allowed`}
      }
    }
    next(err)
  })
  .get('/:id', (req, res, next) => {
    res.json(req.address)
  })
  .put('/:id', (req, res, next) => {
    let { body } = req

    if (!body.street) return next({code: 406, msg: 'street is mandatory'})
    if (!body.zipcode) return next({code: 406, msg: 'zipcode is mandatory'})
    if (!body.city) return next({code: 406, msg: 'city is mandatory'})

    $.cache.set(body.id, body)
    res.json(body)
  })
  .delete('/:id', (req, res, next) => {
    $.cache.del(req.address.id)
  })
