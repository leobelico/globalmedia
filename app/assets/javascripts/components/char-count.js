function char_count() {
	$("[data-max-chars]").each(function(){
		$(this).parent().prepend('<label class="char-counter">' + "0" + "/" + $(this).data("max-chars") + '</label>');
		$(this).on("keydown keyup", function(event){
			$(event.target).parent().find(".char-counter").text($(event.target).val().length + "/" + $(event.target).data("max-chars"));
			// console.log($(event.target).val().length + "/" + $(event.target).data("max-chars"));
			if ( $(event.target).val().length > parseInt($(event.target).data("max-chars")) && $(event.target).hasClass(".cc-warn") == false){
				$(event.target).addClass("cc-warn");
				$(event.target).parent().find(".char-counter").addClass("cc-warn");
				$(event.target).parent().find("label").addClass("cc-warn");
				console.log("")
			} else {
				if  ($(event.target).hasClass("cc-warn")) {
					$(event.target).removeClass("cc-warn");
					$(event.target).parent().find(".char-counter").removeClass("cc-warn");
				$(event.target).parent().find("label").removeClass("cc-warn");
				}
			}
		});
	});
}