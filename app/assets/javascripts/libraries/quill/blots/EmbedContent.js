class EmbedContentBlot extends BlockEmbed {
  static create(src) {
    let node = super.create();
    node.src = src; 
    return node;
  }
  static value(domNode) {
    domNode.onload = iframeLoaded(domNode);
    return domNode.src;
  }
}

EmbedContentBlot.blotName = 'embed-content';
EmbedContentBlot.tagName = 'iframe';
EmbedContentBlot.className = 'embed-content';