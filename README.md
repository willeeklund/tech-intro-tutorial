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

Throughout the entire tutorial I recommend you to make a commit of the changes you made
after a couple of sections. This will give you a good overview of all changes,
one of many advantages of using version control.

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

    var path = require('path');
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

#### Event listener and Ajax calls
Add a button element in `index.hbs`. Also add an empty list.

    <button id="ourButton">Fetch from server</button>
    <ul class="fetchedItems"></ul>

Then in `app.js`, add event listener for the 'click' event on the button.
When it is clicked, perform an Ajax call and add the list of images to this new list.

    jQuery('#ourButton').on('click', function () {
        jQuery.ajax({
            url: '/animal_list_data'
        }).done(function (data) {
            console.log('fetched data', data.animals);
            data.animals.forEach(function (item) {
                jQuery('.fetchedItems').append('<li><img src="' + item + '" width="60" /></li>');
            });
        });
    });


## iOS application

#### Create the iOS application
Open XCode and create a new project. Choose 'Single-View Application' as the template.
Call the project 'Tech-intro' and 'com.netlight' as organization identifier.
The programming language we will use is Swift.

#### Fetch JSON list of animal images
Our iOS app will contain a table where we show the animal images.
The first step is the fetch the JSON file from
[http://localhost:3000/animal_list_data](http://localhost:3000/animal_list_data).

Go to `ViewController.swift`. First add this property to the class where the class body begins.

    var imageList = Array<String>()

Then add this call in the end of `viewDidLoad()`.

    self.fetchAnimalList()

Then add that function to the class.

    func fetchAnimalList() {
        // Boilerplate stuff to make network request
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration);
        let listURL = NSURL(string: "http://localhost:3000/animal_list_data")!
        let request = NSURLRequest(URL: listURL)
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if nil != error {
                print("Something went wrong fetching data. \(error)")
                return
            }
            // Parse response data as JSON and get the part we want
            var JSONError: NSError?
            if let responseDict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: &JSONError) as? NSDictionary {
                if nil != JSONError {
                    print("Something went wrong parsing JSON data. \(JSONError)")
                    return
                }
                if let animalsList = responseDict["animals"] as? Array<String> {
                    // Save list of images
                    self.imageList = animalsList
                    print("animalsList = \(animalsList)")
                } else {
                    print("JSON data has no 'animals' field. \(responseDict)")
                }
            }
        })
        // This is when the request is actually started
        task.resume()
    }

Now you can run the application and see the console log with the list of images.


#### Connect UI elements

Open the storyboard file (`Main.storyboard`) and show the Utilities section on the right.
From the list of user interface elements, drag a Table view into the storyboard.

![Drag Table view element](https://raw.githubusercontent.com/willeeklund/tech-intro-tutorial/master/images/storyboard1.png)

Also drag in a Button element. Then mark both the Table view and button (Command-click),
then click the icon to resolve auto layout issues in the bottom right of the storyboard.
Select 'Reset to suggested constraints'.

![Resolve auto layout](https://raw.githubusercontent.com/willeeklund/tech-intro-tutorial/master/images/storyboard2.png)

Next bring up the Assistant editor.

![Assistant editor](https://raw.githubusercontent.com/willeeklund/tech-intro-tutorial/master/images/assistant_editor.png)

Mark the Table view element on the left, then Control-drag it into the right side.
Name the element `tableview`.

![Connect tableview](https://raw.githubusercontent.com/willeeklund/tech-intro-tutorial/master/images/connect_tableview.png)

The `tableview` element is now connected as a property of the `ViewController` class.


#### Show images in table list
In `ViewController.swift`, update the class definition to this:

    class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

These are two protocols that the class will conform to.

They mean the class can both handle the events that concern a table view (as it's delegate)
and it can provide the data to fill the table with content (data source).

In `viewDidLoad()`, add assignment for the tableview responsibilities to the class
before we call `fetchAnimalList()`.

    self.tableview.delegate = self
    self.tableview.dataSource = self

Then add these methods to make it act as a data source.

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "animalImage"
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if nil == cell {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        let imagePath = self.imageList[indexPath.row]
        cell?.textLabel?.text = "Image \(indexPath.row): \(imagePath)"
        return cell!
    }

But if we run the application now the table will not be populated with image links because
of a timing issue. At the time the length of imageList is read it will be zero,
because the call to fetch the list has not finished yet. Change the definition of `imageList`
to fix this.

    var imageList = Array<String>() {
        didSet {
            dispatch_async(dispatch_get_main_queue(), {
                self.tableview.reloadData()
            })
        }
    }


Try to run the application again. Now it should do what we want.

If you try to comment out the `dispatch_async` parts it will not work, because the call to
reload the data is not applied on the main queue in the application. This is the only queue
that will update the UI.


#### Show image in table
To show the image from the URL we need to load the content of that URL and present it as
an image in out table view cell. Just before we return the cell in `cellForRowAtIndexPath`,
add these lines.

    // Show the image, but load in background queue
    let backgroundQueue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
    dispatch_async(backgroundQueue) {
        if let url = NSURL(string: imagePath) {
            if let data = NSData(contentsOfURL: url) {
                dispatch_async(dispatch_get_main_queue(), {
                    // Update table cell in main queue
                    cell?.textLabel?.text = "Image \(indexPath.row)"
                    cell?.imageView?.image = UIImage(data: data)
                    cell?.setNeedsDisplay()
                    println("Got image \(indexPath.row)")
                })
            }
        }
    }

This will load the data in background and then update the cell. If the queue changing code
is commented out it will all load on the main queue and the UI will freeze. Try it out!


#### Button click event
In the frontend part we added a click event listener for a button. Now we will do the same
in iOS. Bring up the Assistant editor again and Control-drag from the button in the
storyboard into the class, but this time choose connection type 'Action' instead out 'Outlet'.
name the action `buttonWasClicked` and choose the event type 'Touch Up Inside'. This is a
regular 'Click'.

![Connect button click](https://raw.githubusercontent.com/willeeklund/tech-intro-tutorial/master/images/connect_button_click.png)

Update the content of the new action method to this.

    @IBAction func buttonWasClicked(sender: UIButton) {
        // Change button color
        if nil == sender.backgroundColor {
            sender.backgroundColor = UIColor.redColor()
        } else {
            sender.backgroundColor = nil
        }
    }

This will toggle a red background of the button when clicked.

