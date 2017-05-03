$(document).on("click", function(event){
  if ( $(event.target).is(".save-article") ) {
    if ($(event.target).attr("data-slug")){      
      submit_form("update", $(event.target).data("slug")); 
    } else {
      submit_form("create"); 
    }
  }
}); 

function submit_form(action, slug){

  console.log(editor.getContents()) 
  console.log(editor.getText())


  var quill_note = editor.getContents();
  var text_note = editor.getText();

  if (action == "create") {
    url = "/panel/articles"; 
    type = "POST"
  }
  if (action == "update") {
    url = "/panel/articles/" + slug; 
    type = "PUT";
  }
  button = $(event.target);
  show_button_spinner(button);

  $.ajax({
    url: url,
    type: type,
    data: {
      article: {
        name: $("#article_name").val(),
        short_description: $("#article_short_description").val(),
        articable_id: $("#article_articable_id").val(),
        articable_type: $("#article_articable_type").val(),
        hashtags_names: $("#hashtags").val(), 
        plain_text: text_note,
        note: JSON.stringify(quill_note),
        keyword_id: $("#article_keyword_id").val(),
        image: $("input[type='hidden'][name='article[image]']").val(),
        draft: $("#article_draft").val(),
        video_url: $("#article_video_url").val(),
        author_id: $("#article_author_id").val()
        
       
      },
        scheduled_time_3i: $("#article_scheduled_time_3i").val(),
        scheduled_time_2i: $("#article_scheduled_time_2i").val(),
        scheduled_time_1i: $("#article_scheduled_time_1i").val(),
        scheduled_time_4i: $("#article_scheduled_time_4i").val(),
        scheduled_time_5i: $("#article_scheduled_time_5i").val()
    }
  })
  .done(function() {
    console.log("success");
  })
  .fail(function() {
    console.log("error");
    hide_button_spinner(button);
    $(".admin-form.form--article.card").prepend('<h4 class="small-title delete" style="margin-bottom:  18px; ">Asegurate de llenar todos los campos de la forma.</h4>')
    $(".admin-form.form--article.card").append('<h4 class="small-title delete" style="margin-top:  18px; ">Asegurate de llenar todos los campos de la forma.</h4>')
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
function hide_button_spinner(button) {
  TweenMax.to(button.find(".button--text"), .3, {
    y:  0, delay: 1 
  }); 
  TweenMax.to(button.find(".button--spinner"), .3, {
    y:  "-=33", delay: 1 
  });
  TweenMax.to(button.find(".button--spinner"), 1, {
    rotation:  360,
    repeat:  -1,
    ease: Power0.easeNone
  }); 
}
