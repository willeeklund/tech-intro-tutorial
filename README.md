# tech-intro-tutorial
Short tutorial to get familiar with some technologies during a night.


## Prerequisites

#### Install XAMPP
XAMPP is a quick way to get Apache, MySQL and PHP working on your local computer.

Install from [this link](https://www.apachefriends.org/download.html).

Any of the linked versions will work.

Open the download file and follow the installation guide.

Visit [http://localhost/](http://localhost/) and see some short info that you installation works as expected.

#### Install XCode
To make the iOS app part of this tutorial you need to use a Mac computer, because it is not possible to make iOS development otherwise.

Install XCode from the [Mac App store](https://itunes.apple.com/us/app/xcode/id497799835?mt=12).

Open XCode and let it install the additional components it requires, such as command line tools.

This will install Git, the version control system.


## Start coding

#### Create your PHP application
Visit the folder where the XAMPP application was installed. The default on a Mac is /Applications/XAMPP/.
Inside the "htdocs" folder, create a new folder named "my_php_app".
In the folder "my_php_app", save a new file named index.php with the following content:

    <?php echo "Hello world!"; ?>

Now open [http://localhost/my_php_app/](http://localhost/my_php_app/) in your browser and marvel at your first PHP page!

