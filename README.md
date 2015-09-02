# tech-intro-tutorial
Short tutorial to get familiar with some technologies during a night.


## Prerequisites

#### Install Node
Node.js is a modern framework which include both a web server (listen to traffic on a port)
and responding to server requests.

Install from [this link](https://nodejs.org/download/).

Open the download file and follow the installation guide.


#### Install XCode
To make the iOS app part of this tutorial you need to use a Mac computer, because it is not possible to make iOS development otherwise.

Install XCode from the [Mac App store](https://itunes.apple.com/us/app/xcode/id497799835?mt=12).

Open XCode and let it install the additional components it requires, such as command line tools.

This will install Git, the version control system.

#### Install Github client
Github has a graphical interface client for Git. Download [from their website](https://desktop.github.com/).
Install and start the app. Create a [Github account](https://github.com/join) if you do not have one already.


## Start coding the backend

#### Create your Node application
Go to the folder where you want to store your code. Then run these commands.

    npm init

Follow instructions, just push enter. This will create a file called package.json
containing information about your node.js application, such as it's dependencies.

Then run this from command line.

    npm install express --save

This will install the module "Express" which is the web server we will use. Hbs is a
template engine we will use.

Create a new file named `index.js` with the following content:

    var express = require('express');
    var app = express();
    var server = app.listen(3000, function () {
      console.log('Example app listening at http://localhost:3000');
    });
    app.get('/', function (req, res) {
      res.send('Hello World!');
    });

To run the server you run this command:

    node index.js

Now open [http://localhost:3000/](http://localhost:3000/) in your browser and marvel at
your first Node.js page!

Note: In the continued tutorial you need to restart the node server after each change to `index.js`.


#### List of images
Next create a new endpoint in the same file (`index.js`) by adding this content:

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

Now you can see a JSON list of animal images on [http://localhost:3000/animal_list_data](http://localhost:3000/animal_list_data).


#### Show list of images
Add this code to `index.js`.

    app.get('/simple_list_of_images', function (req, res) {
      var returnString = '<ul>';
      list_of_animal_images.forEach(function (image) {
        returnString += '<li><img src="' + image + '" width="400"></li>';
      });
      returnString += '</ul>';
      res.send(returnString);
    });

Now you can see a list of the images on [http://localhost:3000/simple_list_of_images](http://localhost:3000/simple_list_of_images).


#### Clean up code using template engine
This code will soon become messy, interchanging app logic and the presentation of data.

To separate those two concepts we will install a template engine. Run this command from command line.

    npm install hbs --save

Now add these lines of code in the beginning of `index.js` (after the variable `app` has been created).

    var hbs = require('hbs');
    app.set('view engine', 'hbs');
    app.set('views', path.join(__dirname, '/views'));

Create a folder named `views` and in that create a file named `index.hbs` with this content.

    <h1>{{ headline }}</h1>
    This is a test template.
    <ul>
        {{#each images}}
            <li><img src="{{ this }}" width="400"></li>
        {{/each}}
    </ul>

Also add a file named `layout.hbs` in the `views` folder with this content.

    <!DOCTYPE html>
    <head>
      <meta charset='utf-8'>
      <title>Tech intro tutorial</title>
      <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0'>
    </head>
    <body>
      {{{ body }}}
    </body>
    </html>

Update the '/' endpoint of `index.js` to this

    app.get('/', function (req, res) {
      res.render('index', {
        headline: 'My headline',
        images: list_of_animal_images
      });
    });

Visit [http://localhost:3000/](http://localhost:3000/) and you
will see the same list of images, but this code will be much simpler to maintain.

#### Prepare for frontend application
We need to make some more changes before we can start building the frontend of our application.
Add this to `index.js` to be able to serve static files.

    app.use(express.static(path.join(__dirname, 'public')));

Also create the folders and files we will need for our frontend application. This should
be the resulting tree structure of your working folder.

    nodejs_app/
    ├── index.js
    ├── public
    │   └── assets
    │       ├── css
    │       │   └── main.css
    │       └── js
    │           └── app.js
    └── views
        ├── index.hbs
        └── layout.hbs

The last preparation is to add the loading of `main.css` and `app.js` in `layout.hbs`.
In the `<head>` part add:

    <link rel='stylesheet' type='text/css' href='/assets/css/main.css'>

And after `{{{ body }}}` but before `</body>` add this:

    <script src='//code.jquery.com/jquery-1.11.3.min.js'></script>
    <script src='/assets/js/app.js'></script>

This will first load the jQuery framework, and then add our own code, which depends on jQuery.


## Start building the frontend

#### jQuery image gallery
We will show the animal images in an image gallery in the frontend of our web application.

Update `main.css` to contain this styling.

    .previous, .next {
        font-size: 9em;
    }
    .previous {
        float: left;
    }
    .next {
        float: right;
    }

Change the list of images (the `<ul>` element) in `index.hbs` to this structure.

    <div id="liquid">
        <span class="previous">&#9668;</span>
        <div class="wrapper">
            <ul>
                {{#each images}}
                    <li><a href="#"><img src="{{ this }}" width="400" alt="image"/></a></li>
                {{/each}}
            </ul>
        </div>
        <span class="next">&#9658;</span>
    </div>

Add this script in `layout.hbs`, after we include jQuery, but before we load `app.js`.

    <script src='http://www.nikolakis.net/liquidcarousel/js/jquery.liquidcarousel.pack.js'></script>

Finally add this as the content of `app.js`.

    jQuery(document).ready(function() {
        jQuery('#liquid').liquidcarousel({
            height: 300
        });
    });

Now reload your browser at [http://localhost:3000/](http://localhost:3000/) and your images
are in a carousel!


## Create the iOS application
Open XCode and create a new project.