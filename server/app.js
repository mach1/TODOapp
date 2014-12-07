var express = require('express');
var livereload = require('connect-livereload');

var router = express.Router();
var bodyParser = require('body-parser');

var mongo = require('mongodb');
var monk = require('monk');
var db = monk('localhost:27017/todoapp');

var app = express();

app.use(router);
app.use(livereload());
app.use(express.static(__dirname + '/../webapp/dist'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended : true
}));

router.post('/adduser', function(req, res) {
  var usercollection = db.get('usercollection');
  usercollection.insert(req.body.user);
}); 


module.exports = app;
