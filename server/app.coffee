express = require 'express'
livereload = require 'connect-livereload'

router = express.Router()
bodyParser = require 'body-parser'

mongo = require 'mongodb'
monk = require 'monk'
db = monk 'localhost:27017/todoapp'

app = express()

app.use livereload()
app.use express.static(__dirname + '/../webapp/dist')
app.use bodyParser.json()
app.use bodyParser.urlencoded
  extended : true

app.use(router)


router.post '/adduser', (req, res) ->
  usercollection = db.get 'usercollection'
  usercollection.insert req.body.user

module.exports = app
