$(document).on("click", function(event) {
  if ($(event.target).is(".save-article")) {
    const slug = $(event.target).attr("data-slug");
    submit_form(slug ? "update" : "create", slug || "", event);
    TweenMax.set($(event.target), { pointerEvents: "none" });
  }

  if ($(event.target).is(".add-gallery")) {
    const slug = $(event.target).attr("data-slug");
    submit_form(slug ? "update" : "create", slug || "", event, true);
    TweenMax.set($(event.target), { pointerEvents: "none" });
  }
});


function submit_form(action, slug, event, go_to_gallery = false) {
  console.log($("#article_articable_id").val());
  console.log(editor.getContents());
  console.log(editor.getText());

  const quill_note = editor.getContents();
  const text_note = editor.getText();

  const url = action === "create" ? "/panel/articles" : `/panel/articles/${slug}`;
  const type = action === "create" ? "POST" : "PUT";
  const button = $(event.target);
  show_button_spinner(button);

  const hashtags = $("#hashtags").val();
  const noticias = hashtags.length === 0 ? "noticias" : "";

  $.ajax({
    url: url,
    type: type,
    data: {
      article: {
        name: $("#article_name").val(),
        short_description: $("#article_short_description").val(),
        articable_id: $("#article_articable_id").val(),
        articable_type: $("#article_articable_type").val(),
        hashtags_names: hashtags + noticias,
        plain_text: text_note,
        note: JSON.stringify(quill_note),
        keyword_id: $("#article_keyword_id").val(),
        image: $("input[type='hidden'][name='article[image]']").val(),
        draft: $("#article_draft").val(),
        video_url: $("#article_video_url").val(),
        author_id: $("#article_author_id").val(),
        exclusive: $("#article_exclusive").val(),
        meta_tags: $("#article_meta_tags").val(),
        breaking_news: $("#breaking_news").is(":checked") ? 1 : 0,
        images: {}
      },
      scheduled_time_3i: $("#article_scheduled_time_3i").val(),
      scheduled_time_2i: $("#article_scheduled_time_2i").val(),
      scheduled_time_1i: $("#article_scheduled_time_1i").val(),
      scheduled_time_4i: $("#article_scheduled_time_4i").val(),
      scheduled_time_5i: $("#article_scheduled_time_5i").val(),
      gallery_images: go_to_gallery
    }
  })
  .done(function() {
    console.log("✅ success");
    // Aquí puedes redirigir o limpiar formulario si quieres
  })
  .fail(function(jqXHR, textStatus, errorThrown) {
    console.error("❌ Error status:", textStatus);
    console.error("❌ Error thrown:", errorThrown);
    console.error("❌ Respuesta del servidor:", jqXHR.responseText);

    hide_button_spinner(button);
    TweenMax.set(button, { pointerEvents: "all" });

    $(".admin-form.form--article.card h4").remove();

    $(".admin-form.form--article.card").prepend(
      `<h4 class="small-title delete" style="margin-bottom:18px;">
        ❌ Error ${jqXHR.status} – ${errorThrown}<br>
        📋 Detalles: ${jqXHR.responseText}
      </h4>`
    );
  });
}


function show_button_spinner(button) {
  TweenMax.to(button.find(".button--text"), 0.3, { y: 31 });
  TweenMax.to(button.find(".button--spinner"), 0.3, { y: -9 });
  TweenMax.to(button.find(".button--spinner"), 1, {
    rotation: 360,
    repeat: -1,
    ease: Power0.easeNone
  });
}

function hide_button_spinner(button) {
  TweenMax.to(button.find(".button--text"), 0.3, { y: 0, delay: 1 });
  TweenMax.to(button.find(".button--spinner"), 0.3, { y: "-=33", delay: 1 });
  TweenMax.to(button.find(".button--spinner"), 1, {
    rotation: 360,
    repeat: -1,
    ease: Power0.easeNone
  });
}
