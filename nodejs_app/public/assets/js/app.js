/* Our frontend application code goes here */

jQuery(document).ready(function() {
    jQuery('#liquid').liquidcarousel({
        height: 300
    });
});

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
