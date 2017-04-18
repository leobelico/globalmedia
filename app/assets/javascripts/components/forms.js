function saveFormOnButtonClick(button, form){
	$(document).on("click", function(event){
		if ( $(event.target).is(button) || $(event.target).is(button.find("*")) ){
			form.submit(); 
		}
	});   
}