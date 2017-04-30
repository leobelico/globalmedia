$(document).on("click", function(event){
	if ( $(event.target).is(".copy") ) {
		clipboard.copy($(event.target).find("input").val());

	}
});