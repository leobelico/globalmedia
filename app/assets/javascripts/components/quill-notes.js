function display_quill_note(quill_note, container) {
  var options = {
    readOnly: true,
    theme: 'snow'
  }
  
  // Importaciones necesarias
  Parchment = Quill.import('parchment');
  Delta = Quill.import('delta');
  
  // Registrar blots personalizados
  Quill.register(TweetBlot);
  Quill.register(EmbedContentBlot);
  Quill.register(InstagramBlot);

  // Usar window.editor para mantener consistencia
  window.quillViewer = new Quill(container, options);
  window.quillViewer.setContents(quill_note);
}