// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/autocomplete
//= require autocomplete-rails
//= require turbolinks
//= require_directory .
//= require libraries/gsap/TweenMax.min
//= require libraries/money
//= require libraries/quill/quill.min 
//= require libraries/clipboard.js/clipboard.min 
//= require libraries/videojs/video.min
//= require libraries/videojs/hls
//= require components/media-cache-cleaner
// 
// 
// QUILL BLOTS
// 
//= require libraries/quill/blots/Tweet 
//= require libraries/quill/blots/EmbedContent 
//= require libraries/quill/blots/Instagram 
// 
// 
//  QUILL FUNCTIONS
// 
//= require libraries/quill/functions/createInstagramEmbed 
// 
//  COMPONENTS 
// 
//= require components/currency-rates
//= require components/weather
//= require components/quill-initializer
//= require components/quill-forms
//= require components/quill-notes
//= require components/forms
//= require components/post-share
//= require components/char-count
//= require components/copy-to-clipboard
//= require components/mobile-menu


function add_fields(link, association, content) { 
//
    var new_id = new Date().getTime();  
    var regexp = new RegExp("new_" + association, "g");  
    $(link).parent().append(content.replace(regexp, new_id));
    TweenMax.to(".field-builder", 1.2, {maxHeight: 200, overflow:  "hidden"})
}

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".field-builder").hide();
  TweenMax.to($(link).parent(), .6, { height:  0, overflow:  "hidden", marginBottom:  0});
}