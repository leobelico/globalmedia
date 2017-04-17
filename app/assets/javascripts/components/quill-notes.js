function display_quill_note(quill_note, container) {
	var options = {
	  readOnly: true
	}


	var editor = new Quill(container, options);

	editor.setContents(quill_note);
}
