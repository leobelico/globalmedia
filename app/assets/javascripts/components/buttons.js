$(document).on("click touchstart", function(event){
	if ($(event.target).is(".toggle.toggle--inactive")) {
		$toggle_button = $(event.target).find(".toggle__button"); 
		$toggle_background = $(event.target).find(".toggle__background"); 
		TweenMax.to($toggle_button, .3, { x: 25, ease: Power2.easeOut });
		TweenMax.to($toggle_background, .425, { scale: "0", ease: Power2.easeOut });
		$(event.target).removeClass("toggle--inactive");
		$(event.target).addClass("toggle--active");

	}
	else {
		if ($(event.target).is(".toggle.toggle--active")) {
			$toggle_button = $(event.target).find(".toggle__button"); 
			$toggle_background = $(event.target).find(".toggle__background"); 
			TweenMax.to($toggle_button, .3, { x: 0, ease: Power2.easeOut });
			TweenMax.to($toggle_background, .425, { scale: "1", ease: Power2.easeOut });
			$(event.target).removeClass("toggle--active");
			$(event.target).addClass("toggle--inactive");
		}
	}

	if ($(event.target).is(".set-highlight")){
		setHighlight(event.target); 
		console.log("set high")
	}
	if ($(event.target).is(".set-recommendation")){
		console.log("set recommendation")
		setRecommendation(event.target); 
	}
});

function setHighlight(target) {
	$.ajax({
		url: '/panel/articles/'+$(target).data("slug")+'/set_highlight_from_id',
		type: 'POST',
		data: {article_id: $(target).data("id")},
	})
	.done(function() {
		console.log("success");
	})
	.fail(function() {
		console.log("error");
	})
	.always(function() {
		console.log("complete");
	});

}
function setRecommendation(target) {
	$.ajax({
		url: '/panel/articles/'+$(target).data("slug")+'/set_recommendation_from_id',
		type: 'POST',
		data: {article_id: $(target).data("id")},
	})
	.done(function() {
		console.log("success");
	})
	.fail(function() {
		console.log("error");
	})
	.always(function() {
		console.log("complete");
	});

}