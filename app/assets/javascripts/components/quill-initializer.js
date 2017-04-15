var toolbarOptions = [
  ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
  ['blockquote', 'video', 'image', 'link', 'tweet', 'embed-content'],
  [{ 'header': 1 }, { 'header': 2 }],               // custom button values
  [{ 'list': 'ordered'}, { 'list': 'bullet' }],
  [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
  [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
  [{ 'align': [] }],
  ['clean'],                                        // remove formatting button

  [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
  [{ 'size': ['small', false, 'large', 'huge'] }]  // custom dropdown

];

var options = {
  theme: 'snow',
  modules: {
    toolbar: toolbarOptions
  },
  placeholder: 'Halloween is Coming'
 }

Quill.register(TweetBlot);
Quill.register(EmbedContentBlot);

var container = document.getElementById('note-editor');
var editor = new Quill(container, options);

$('#tweet-button').click(function() {
  let range = quill.getSelection(true);
  quill.insertText(range.index, '\n', Quill.sources.USER);
  quill.insertEmbed(range.index + 1, 'tweet', id, Quill.sources.USER);
  quill.setSelection(range.index + 2, Quill.sources.SILENT);
});
$('#embed-content-button').click(function() {
  let range = quill.getSelection(true);
  quill.insertText(range.index, '\n', Quill.sources.USER);
  quill.insertEmbed(range.index + 1, 'embed-content', src, Quill.sources.USER);
  quill.setSelection(range.index + 2, Quill.sources.SILENT);
});