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


## Start coding

#### Create your Node application
Go to the folder where you want to store your code. Then run these commands.

    npm init

Follow instructions, just push enter. This will create a file called package.json
containing information about your node.js application, such as it's dependencies.

Then run this from command line.

    npm install express --save

This will install the module "Express" which is the web server we will use.

Create a new file named index.js with the following content:

    var express = require('express');
    var app = express();
    var server = app.listen(3000, function () {
      console.log('Example app listening at http://localhost:3000');
    });
    app.get('/', function (req, res) {
      res.send('Hello World!');
    });


Now open [http://localhost:3000/](http://localhost:3000/) in your browser and marvel at
your first Node.js page!


#### List of images
Next create a new endpoint in the same file (index.js) by adding this content:

    app.get('/animal_list_data', function (req, res) {
      res.header('Content-Type', 'application/json');
      res.send({
        'animals': [
            'http://www.extremetech.com/wp-content/uploads/2013/09/4Vln8-640x428.jpg',
            'http://threeriversvetgroup.co.uk/wp-content/uploads/2012/05/farm-animals.jpg',
            'http://i.kinja-img.com/gawker-media/image/upload/b7wucih6xfq6b8wjuurb.jpg',
            'http://justsomething.co/wp-content/uploads/2013/11/cutest-baby-animals-21.jpg',
            'http://s3-us-west-1.amazonaws.com/www-prod-storage.cloud.caltech.edu/styles/article_photo/s3/CT_Brain-Animal-Recog_SPOTLIGHT.jpg?itok=i4fXi7PO',
            'http://www.bestfunnyjokes4u.com/wp-content/uploads/2012/12/talking-animals-joke.jpg',
            'http://udel.edu/~emmaauf/website%20project/final%20webpage/farmanimals/images/duckling.jpg'
        ]
      });
    });

Now you can see a JSON list of animal images on [http://localhost:3000/animal_list_data](http://localhost:3000/animal_list_data).


