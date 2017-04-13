$(document).on("click", function(event){
  if ( $(event.target).is(".saver--article") ) {
    show_button_spinner($(event.target));

    console.log(editor.getContents()) 
    console.log(editor.getText())




    $.ajax({
      url: '/path/to/file',
      type: 'default GET (Other values: POST)',
      dataType: 'default: Intelligent Guess (Other values: xml, json, script, or html)',
      data: {
        name: $("#article_name").val(),
        short_description: $("#article_short_description").val(),
        articable_type: $("#article_articable_type").val(),
        hashtag_names: $("#article_hashtags_names").val(), 
        note: editor.getContents(), 
        plain_text: editor.getText()
      },
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
}); 

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