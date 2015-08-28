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

#### Install Github client
Github has a graphical interface client for Git. Download [from their website](https://desktop.github.com/).
Install and start the app. Create a [Github account](https://github.com/join) if you do not have one already.


## Start coding

#### Create your PHP application
Visit the folder where the XAMPP application was installed. The default on a Mac is /Applications/XAMPP/.
Inside the "htdocs" folder, create a new folder named "my_php_app".
In the folder "my_php_app", save a new file named index.php with the following content:

    <?php echo "Hello world!"; ?>

Now open [http://localhost/my_php_app/](http://localhost/my_php_app/) in your browser and marvel at your first PHP page!


#### List of images
Next create a new file "animal_list_data.php" and fill it with this content:

    <?php
    $animal_image_list = array(
        "animals" => array(
            "http://www.extremetech.com/wp-content/uploads/2013/09/4Vln8-640x428.jpg",
            "http://threeriversvetgroup.co.uk/wp-content/uploads/2012/05/farm-animals.jpg",
            "http://i.kinja-img.com/gawker-media/image/upload/b7wucih6xfq6b8wjuurb.jpg",
            "http://justsomething.co/wp-content/uploads/2013/11/cutest-baby-animals-21.jpg",
            "http://s3-us-west-1.amazonaws.com/www-prod-storage.cloud.caltech.edu/styles/article_photo/s3/CT_Brain-Animal-Recog_SPOTLIGHT.jpg?itok=i4fXi7PO",
            "http://www.bestfunnyjokes4u.com/wp-content/uploads/2012/12/talking-animals-joke.jpg",
            "http://udel.edu/~emmaauf/website%20project/final%20webpage/farmanimals/images/duckling.jpg"
        )
    );
    header("Content-Type: application/json");
    echo json_encode($animal_image_list);
    ?>

Now you can see a JSON list of animal images on [http://localhost/my_php_app/animal_list_data.php](http://localhost/my_php_app/animal_list_data.php).

