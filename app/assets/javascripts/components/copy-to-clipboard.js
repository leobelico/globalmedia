$(document).on("click touchend", function(event){
	if ( $(event.target).is(".copy") ) {
		// clipboard.copy($(event.target).find("input").val());
		var clipboard = new Clipboard('.copy');
		
		TweenMax.fromTo(".copied-link", .3, {
			y: -36, 
			opacity:  0
		},{
			y: 0, 
			opacity: 1
		});
		TweenMax.to(".copied-link", .3, {
			y: 36, 
			opacity:  0,
			delay: 1
		})
	}
});