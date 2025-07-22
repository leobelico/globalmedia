function initialize_quill(){
  material_colors = ["#FFEBEE", "#ffcdd2", "#ef9a9a", /* ... mantén tus colores ... */, "#ffffff", "#A5ECDD"];
  
  var toolbarOptions = [
    ['bold', 'italic', 'underline', 'strike'],
    ['blockquote', 'video', 'image', 'link', 'tweet', 'embed-content', 'instagram'],
    [{ 'header': 1 }, { 'header': 2 }],
    [{ 'list': 'ordered'}, { 'list': 'bullet' }],
    [{ 'indent': '-1'}, { 'indent': '+1' }],
    [{ 'color': material_colors }, { 'background': material_colors }],
    [{ 'align': [] }],
    ['clean'],
    [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
    [{ 'size': ['small', false, 'large', 'huge'] }]
  ];

  var options = {
    theme: 'snow',
    modules: {
      toolbar: toolbarOptions
    },
    placeholder: 'Escribe aquí la nota...'
  };

  Parchment = Quill.import('parchment');
  Delta = Quill.import('delta');
  Quill.register(InstagramBlot);
  Quill.register(TweetBlot);
  Quill.register(EmbedContentBlot);

  container = document.getElementById('note-editor');
  window.editor = new Quill(container, options);

  $('#tweet-button').click(function() {
    var range = window.editor.getSelection(true);
    window.editor.insertText(range.index, '\n', Quill.sources.USER);
    window.editor.insertEmbed(range.index + 1, 'tweet', id, Quill.sources.USER);
    window.editor.setSelection(range.index + 2, Quill.sources.SILENT);
  });
  
  $('#embed-content-button').click(function() {
    var range = window.editor.getSelection(true);
    window.editor.insertText(range.index, '\n', Quill.sources.USER);
    window.editor.insertEmbed(range.index + 1, 'embed-content', src, Quill.sources.USER);
    window.editor.setSelection(range.index + 2, Quill.sources.SILENT);
  });
  
  $('#instagram').click(function() {
    var range = window.editor.getSelection(true);
    window.editor.insertText(range.index, '\n', Quill.sources.USER);
    window.editor.insertEmbed(range.index + 1, 'instagram', src, Quill.sources.USER);
    window.editor.setSelection(range.index + 2, Quill.sources.SILENT);
  });
}