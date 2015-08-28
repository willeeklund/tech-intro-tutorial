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
