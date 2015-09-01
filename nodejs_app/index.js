var path = require('path');
var express = require('express');
var app = express();

// Add Handlebars template engine
var hbs = require('hbs');
app.set('view engine', 'hbs');
app.set('views', path.join(__dirname, '/views'));

// Make the app listen to port 3000
app.listen(3000, function () {
  console.log('Example app listening at http://localhost:3000');
});

app.get('/', function (req, res) {
  res.render('index', {
    headline: 'My headline',
    images: list_of_animal_images
  });
});

var list_of_animal_images = [
  'http://www.extremetech.com/wp-content/uploads/2013/09/4Vln8-640x428.jpg',
  'http://threeriversvetgroup.co.uk/wp-content/uploads/2012/05/farm-animals.jpg',
  'http://i.kinja-img.com/gawker-media/image/upload/b7wucih6xfq6b8wjuurb.jpg',
  'http://justsomething.co/wp-content/uploads/2013/11/cutest-baby-animals-21.jpg',
  'http://s3-us-west-1.amazonaws.com/www-prod-storage.cloud.caltech.edu/styles/article_photo/s3/CT_Brain-Animal-Recog_SPOTLIGHT.jpg?itok=i4fXi7PO',
  'http://www.bestfunnyjokes4u.com/wp-content/uploads/2012/12/talking-animals-joke.jpg',
  'http://udel.edu/~emmaauf/website%20project/final%20webpage/farmanimals/images/duckling.jpg'
];
app.get('/animal_list_data', function (req, res) {
  res.header('Content-Type', 'application/json');
  res.send({
    'animals': list_of_animal_images
  });
});

app.get('/simple_list_of_images', function (req, res) {
  var returnString = '<ul>';
  list_of_animal_images.forEach(function (image) {
    returnString += '<li><img src="' + image + '" width="400"></li>';
  });
  returnString += '</ul>';
  res.send(returnString);
});

