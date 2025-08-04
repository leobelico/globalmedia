// =============================================
// BLOTS PERSONALIZADOS
// =============================================

const BlockEmbed = Quill.import('blots/block/embed');

// 1. Blot para Twitter
class TweetBlot extends BlockEmbed {
  static create(id) {
    // Extraer ID de la URL si es necesario
    const tweetId = id.match(/\d+$/)?.[0] || id;
    const node = super.create();
    node.dataset.id = tweetId;
    node.innerHTML = `
      <div class="tweet-embed" data-id="${tweetId}">
        <blockquote class="twitter-tweet">
          <a href="https://twitter.com/x/status/${tweetId}">Cargando tweet...</a>
        </blockquote>
      </div>
    `;
    
    if (!window.twttr) {
      const script = document.createElement('script');
      script.src = 'https://platform.twitter.com/widgets.js';
      script.async = true;
      document.body.appendChild(script);
    } else {
      window.twttr.widgets.load();
    }
    return node;
  }

  static value(node) {
    return node.dataset.id;
  }
}
TweetBlot.blotName = 'tweet';
TweetBlot.tagName = 'div';
TweetBlot.className = 'tweet-embed';

// 2. Blot para Instagram
class InstagramBlot extends BlockEmbed {
  static create(url) {
    const regExp = /(?:https?:\/\/)?(?:www\.)?instagram\.com(?:\/[^\/]+)?\/(?:p|reel)\/([^\/?#&]+)/;
    const shortcode = url.match(regExp)?.[1] || url;
    const node = super.create();
    node.dataset.url = url;
    node.innerHTML = `
      <blockquote class="instagram-media" data-instgrm-permalink="https://www.instagram.com/p/${shortcode}/">
        <a href="https://www.instagram.com/p/${shortcode}/">Ver publicación en Instagram</a>
      </blockquote>
    `;
    
    if (!window.instgrm) {
      const script = document.createElement('script');
      script.src = 'https://www.instagram.com/embed.js';
      script.async = true;
      document.body.appendChild(script);
    } else {
      window.instgrm.Embeds.process();
    }
    return node;
  }

  static value(node) {
    return node.dataset.url;
  }
}
InstagramBlot.blotName = 'instagram';
InstagramBlot.tagName = 'div';
InstagramBlot.className = 'instagram-embed';

// 3. Blot para TikTok
class TikTokBlot extends BlockEmbed {
  static create(url) {
    const regExp = /(?:https?:\/\/)?(?:www\.)?tiktok\.com\/@[^\/]+\/video\/(\d+)/;
    const videoId = url.match(regExp)?.[1] || url;
    const node = super.create();
    node.dataset.url = url;
    node.innerHTML = `
      <blockquote class="tiktok-embed" cite="${url}" data-video-id="${videoId}">
        <section>Cargando video de TikTok...</section>
      </blockquote>
    `;
    
    if (!window.tiktokEmbedLoader) {
      const script = document.createElement('script');
      script.src = 'https://www.tiktok.com/embed.js';
      script.async = true;
      script.onload = () => window.tiktokEmbedLoader?.load();
      document.body.appendChild(script);
    } else {
      window.tiktokEmbedLoader.load();
    }
    return node;
  }

  static value(node) {
    return node.dataset.url;
  }
}
TikTokBlot.blotName = 'tiktok';
TikTokBlot.tagName = 'div';
TikTokBlot.className = 'tiktok-embed';

// 4. Blot para contenido embebido genérico
class EmbedContentBlot extends BlockEmbed {
  static create(url) {
    const node = super.create();
    node.dataset.url = url;
    
    // YouTube
    if (url.includes('youtube.com') || url.includes('youtu.be')) {
      const videoId = url.includes('v=') 
        ? url.split('v=')[1].split('&')[0] 
        : url.split('youtu.be/')[1]?.split('?')[0];
      
      if (videoId) {
        node.innerHTML = `
          <div class="video-container">
            <iframe src="https://www.youtube.com/embed/${videoId}" 
              frameborder="0" 
              allowfullscreen>
            </iframe>
          </div>
        `;
      }
    } 
    // Vimeo
    else if (url.includes('vimeo.com')) {
      const videoId = url.split('vimeo.com/')[1]?.split('?')[0];
      if (videoId) {
        node.innerHTML = `
          <div class="video-container">
            <iframe src="https://player.vimeo.com/video/${videoId}" 
              frameborder="0" 
              allowfullscreen>
            </iframe>
          </div>
        `;
      }
    }
    // Genérico
    else {
      node.innerHTML = `
        <div class="generic-embed">
          <a href="${url}" target="_blank">Contenido embebido: ${url}</a>
        </div>
      `;
    }
    
    return node;
  }

  static value(node) {
    return node.dataset.url;
  }
}
EmbedContentBlot.blotName = 'embed-content';
EmbedContentBlot.tagName = 'div';
EmbedContentBlot.className = 'embed-content';

// =============================================
// INICIALIZACIÓN DE QUILL
// =============================================

function initialize_quill() {
  // Configuración del toolbar
  const toolbarOptions = [
    ['bold', 'italic', 'underline', 'strike'],
    ['blockquote', 'code-block', 'video', 'image', 'link'],
    ['tweet', 'instagram', 'tiktok', 'embed-content'], // Nuestros blots personalizados
    [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
    [{ 'list': 'ordered'}, { 'list': 'bullet' }],
    [{ 'indent': '-1'}, { 'indent': '+1' }],
    [{ 'align': [] }], // Justificación (left, center, right, justify)
    [{ 'color': [] }, { 'background': [] }],
    [{ 'font': [] }],
    [{ 'size': ['small', false, 'large', 'huge'] }],
    ['clean']
  ];

  // Opciones de Quill
  const options = {
    theme: 'snow',
    modules: {
      toolbar: {
        container: toolbarOptions,
        handlers: {
          'tweet': function() {
            const url = prompt("Introduce la URL del Tweet:");
            if (url) this.quill.insertEmbed(this.quill.getSelection(), 'tweet', url);
          },
          'instagram': function() {
            const url = prompt("Introduce la URL de Instagram:");
            if (url) this.quill.insertEmbed(this.quill.getSelection(), 'instagram', url);
          },
          'tiktok': function() {
            const url = prompt("Introduce la URL de TikTok:");
            if (url) this.quill.insertEmbed(this.quill.getSelection(), 'tiktok', url);
          },
          'embed-content': function() {
            const url = prompt("Introduce la URL a embeber (YouTube/Vimeo/etc):");
            if (url) this.quill.insertEmbed(this.quill.getSelection(), 'embed-content', url);
          }
        }
      }
    },
    placeholder: 'Escribe tu contenido aquí...'
  };

  // Registrar blots
  Quill.register({
    'formats/tweet': TweetBlot,
    'formats/instagram': InstagramBlot,
    'formats/tiktok': TikTokBlot,
    'formats/embed-content': EmbedContentBlot
  });

  // Inicializar editor
  const container = document.getElementById('editor');
  if (!container) {
    console.error('No se encontró el elemento con ID "editor"');
    return;
  }

  window.quill = new Quill(container, options);
}

// =============================================
// INICIALIZACIÓN AUTOMÁTICA
// =============================================

// Esperar a que todo esté cargado
if (document.readyState === 'complete') {
  initialize_quill();
} else {
  document.addEventListener('DOMContentLoaded', initialize_quill);
}

// =============================================
// CSS RECOMENDADO (agrégalo a tu hoja de estilos)
// =============================================
/*
.ql-editor {
  min-height: 300px;
}

.tweet-embed,
.instagram-embed,
.tiktok-embed,
.embed-content {
  margin: 1rem 0;
  max-width: 100%;
}

.video-container {
  position: relative;
  padding-bottom: 56.25%; // 16:9
  height: 0;
  overflow: hidden;
}

.video-container iframe {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}

.generic-embed {
  padding: 1rem;
  background: #f5f5f5;
  border-left: 4px solid #ccc;
}
*/