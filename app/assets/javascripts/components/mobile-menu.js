menu_open = false;
$(document).on("click", function(event){
	if ( $(event.target).is(".menu-trigger") && menu_open == false ) {
		menu_open = true; 
		TweenMax.to(".mt-1", .2, { top: "+=9", rotation: 45 });
		TweenMax.to(".mt-2", .2, { opacity: 0 });
		TweenMax.to(".mt-3", .2, { top: "-=9", rotation: -45 });
	} else {
		if ( $(event.target).is(".menu-trigger") && menu_open == true ) {
			menu_open = false; 
			TweenMax.to(".mt-1", .2, { top: "-=9", rotation: 0 });
			TweenMax.to(".mt-2", .2, { opacity: 1 });
			TweenMax.to(".mt-3", .2, { top: "+=9", rotation: 0 });	
		}
	}
});