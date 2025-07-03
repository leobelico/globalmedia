//= require jquery
//= require jquery_ujs
//= require jquery-ui/widgets/autocomplete
//= require autocomplete-rails
//= require turbolinks
//= require_tree .
//= require libraries/gsap/TweenMax.min
//= require libraries/money
//= require libraries/quill/quill.min 
//= require libraries/clipboard.js/clipboard.min 
//= require components/buttons
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

// QUILL BLOTS
//= require libraries/quill/blots/Tweet 
//= require libraries/quill/blots/EmbedContent 
//= require libraries/quill/blots/Instagram 

// QUILL FUNCTIONS
//= require libraries/quill/functions/createInstagramEmbed 

// Inicialización después de cargar Turbolinks
$(document).on('turbolinks:load', function() {
  // Manejar clicks en elementos con data-link
  $(document).on("click", "[data-link]", function(event) {
    event.preventDefault();
    window.location.href = $(this).data("link");
  });
  
  // =============================================
  // MANEJO DE CAMPOS DINÁMICOS (SOLUCIÓN COMPLETA)
  // =============================================
  
  // Añadir nuevos campos
  $(document).on('click', '[data-action="add-fields"]', function(e) {
    e.preventDefault();
    e.stopPropagation();
    
    var association = $(this).data('association');
    var content = $(this).data('fields');
    var new_id = new Date().getTime();
    var regexp = new RegExp('new_' + association, 'g');
    
    // Insertar los nuevos campos
    $(this).parent().find('.field-builder').last().after(content.replace(regexp, new_id));
    
    // Animación para el nuevo elemento
    var $newField = $(this).parent().find('.field-builder').last();
    TweenMax.from($newField, 0.5, {
      opacity: 0,
      height: 0,
      onComplete: function() {
        TweenMax.set($newField, { clearProps: 'all' });
      }
    });
  });

  // Eliminar campos
  $(document).on('click', '[data-action="remove-fields"]', function(e) {
    e.preventDefault();
    e.stopPropagation();
    
    var $field = $(this).closest('.field-builder');
    var $destroyField = $field.find('input[type=hidden][name*="_destroy"]');
    
    if ($destroyField.length) {
      $destroyField.val('1'); // Marcar para eliminación
      TweenMax.to($field, 0.5, {
        opacity: 0,
        height: 0,
        marginBottom: 0,
        padding: 0,
        onComplete: function() {
          $field.hide();
        }
      });
    } else {
      // Eliminar directamente si es un nuevo campo no guardado
      TweenMax.to($field, 0.5, {
        opacity: 0,
        height: 0,
        marginBottom: 0,
        padding: 0,
        onComplete: function() {
          $field.remove();
        }
      });
    }
  });

  // =============================================
  // FUNCIONES ADICIONALES EXISTENTES
  // =============================================
  
  function popup(x) {
    $('.popuptext').toggleClass("show");
  }

  function popupout(x) {
    $('.popuptext').toggleClass("show");
  }
  
  // Inicialización de otros componentes
  initializeQuillEditors();
  setupClipboard();
  initMobileMenu();
});

// =============================================
// FUNCIONES DE COMPONENTES
// =============================================

function initializeQuillEditors() {
  // Tu código de inicialización de Quill
}

function setupClipboard() {
  // Tu código para clipboard.js
}

function initMobileMenu() {
  // Tu código para el menú móvil
}