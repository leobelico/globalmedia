$(document).on("click", function(event){
  if ( $(event.target).is(".saver--article") ) {
    submit_form(); 
    
  }
}); 

function submit_form(){
   show_button_spinner($(event.target));

  console.log(editor.getContents()) 
  console.log(editor.getText())


  var quill_note = editor.getContents();
  var text_note = editor.getText();
  $.ajax({
    url: '/panel/articles',
    type: 'POST',
    data: {
      article: {
        name: $("#article_name").val(),
        short_description: $("#article_short_description").val(),
        articable_id: $("#article_articable_id").val(),
        articable_type: $("#article_articable_type").val(),
        hashtag_names: $("#article_hashtags_names").val(), 
        note: { quill: quill_note.ops }, 
        plain_text: text_note          
      }
    }
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

function show_button_spinner(button) {
  TweenMax.to(button.find(".button--text"), .3, {
    y:  31 
  }); 
  TweenMax.to(button.find(".button--spinner"), .3, {
    y:  "-9" 
  });
  TweenMax.to(button.find(".button--spinner"), 1, {
    rotation:  360,
    repeat:  -1,
    ease: Power0.easeNone
  }); 
}