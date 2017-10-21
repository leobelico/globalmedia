function display_quill_note(quill_note, container) {
	var options = {
	  readOnly: true
	}
	// console.log(quill_note)
	Parchment = Quill.import('parchment');
	Delta = Quill.import('delta');
	Quill.register(TweetBlot);
	Quill.register(EmbedContentBlot);
	Quill.register(InstagramBlot);
	// Quill.register(InstagramBlot);

	editor = new Quill(container, options);

	editor.setContents(quill_note);
}
