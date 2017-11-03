menu_open = false;
$(document).on("touchend", function(event){
	console.log(event.target);
	if ( $(event.target).is(".menu-button") && menu_open == false ) {
		menu_open = true; 
		TweenMax.to(".mt-1", .2, { y: "+=9", rotation: 45 });
		TweenMax.to(".mt-2", .2, { opacity: 0 });
		TweenMax.to(".mt-3", .2, { y: "-=9", rotation: -45 });
		TweenMax.to(".mobile-menu", .4, { y: "100%" });
	} else {
		if ( $(event.target).is(".menu-button") && menu_open == true ) {
			menu_open = false; 
			TweenMax.to(".mt-1", .2, { y: "-=9", rotation: 0 });
			TweenMax.to(".mt-2", .2, { opacity: 1 });
			TweenMax.to(".mt-3", .2, { y: "+=9", rotation: 0 });	
			TweenMax.to(".mobile-menu", .4, { y: "0%" });
		}
	}
});