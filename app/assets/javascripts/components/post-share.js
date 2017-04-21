function shareToFacebook(event){
	console.log(event.target);
	console.log($(event.target).parent().data("article"));
	FB.ui({
		method: 'share',
		href: $(event.target).parent().data("article"),
	}, function(response){});
}
