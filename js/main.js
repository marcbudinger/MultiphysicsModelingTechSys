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

  $('p').has('img').css('text-align','center');
	
	
	
	

var coll = document.getElementsByClassName("expand");



for (var i = 0; i < coll.length; i++) { 
	var button = document.createElement("button");
	button.innerHTML = "+";
	button.className = "collapsible";
	coll[i].appendChild(button);
	
	var content = document.createElement('div');
	content.className = "content";
	coll[i].parentNode.insertBefore(content,coll[i].nextSibling);
	var elmt = content.nextElementSibling;
	while(elmt != null && elmt.tagName != "H2"){
		content.appendChild(elmt);
		elmt =  content.nextElementSibling;
	}
	
	coll[i].addEventListener("click", function() {
    this.classList.toggle("active");
	
	var content = this.nextElementSibling ;
	var button =  this.lastChild;
   if (content.style.maxHeight){
      content.style.maxHeight = null;
	  button.innerHTML = "+";
    } else {
      content.style.maxHeight = content.scrollHeight + "px";
	  	 button.innerHTML = "−";
    } 
   
  });
}
	
}


);
function fixLink(siteurl){
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
			if((linktag[i].href.includes(siteurl + "/correctionsen/"+filename) || linktag[i].href.includes(siteurl + "/correctionsfr/"+filename))){
				linktag[i].href = linktag[i].href.replace(".ipynb",".html");
			}
			else {
				linktag[i].href = siteurl + "/files/"+filename;
			}
		}
		
	}
}




