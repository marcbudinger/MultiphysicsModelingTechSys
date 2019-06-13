$(document).ready(function(){


	$("#portfolio-contant-active").mixItUp();


	$("#testimonial-slider").owlCarousel({
	    paginationSpeed : 500,      
	    singleItem:true,
	    autoPlay: 3000,
	});




	$("#clients-logo").owlCarousel({
		autoPlay: 3000,
		items : 5,
		itemsDesktop : [1199,5],
		itemsDesktopSmall : [979,5],
	});

	$("#works-logo").owlCarousel({
		autoPlay: 3000,
		items : 5,
		itemsDesktop : [1199,5],
		itemsDesktopSmall : [979,5],
	});


	// google map
		var map;
		function initMap() {
		  map = new google.maps.Map(document.getElementById('map'), {
		    center: {lat: -34.397, lng: 150.644},
		    zoom: 8
		  });
		}


	// Counter

	$('.counter').counterUp({
        delay: 10,
        time: 1000
    });


}


);


function fixLink(siteurl) {
	var imgtag = document.getElementsByTagName("img");
	for(var i =0; i< imgtag.length;i++)
	{
		if(imgtag[i].src.includes(siteurl)){
			  var filename = imgtag[i].src.replace(/^.*[\\\/]/, '');
			  imgtag[i].src = siteurl + "/img/"+filename;
		}
	
	}
	var linktag = document.getElementsByTagName("a");
	for(var i =0; i< linktag.length;i++)
	{
		if(linktag[i].href.includes(".",linktag[i].href.indexOf(siteurl)+ siteurl.length) && linktag[i].href.includes(siteurl) &&  !linktag[i].href.includes("html")){
			var filename = linktag[i].href.replace(/^.*[\\\/]/, '');
			if((linktag[i].href.includes(siteurl + "/chapitres/"+filename))){
				linktag[i].href = linktag[i].href.replace(".ipynb",".html");
			}
			else {
				linktag[i].href = siteurl + "/files/"+filename;
			}
		}
		
	}
}

