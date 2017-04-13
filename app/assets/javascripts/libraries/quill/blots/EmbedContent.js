class EmbedContentBlot extends BlockEmbed {
  static create(src) {
    let node = super.create();
    node.innerHTML = src; 
  	console.log(node);
    return node;
  }
  static value(domNode) {
    return domNode.src;
  }
}

EmbedContentBlot.blotName = 'embed-content';
EmbedContentBlot.tagName = 'div';
EmbedContentBlot.className = 'embed-content';

