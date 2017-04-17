class EmbedContentBlot extends BlockEmbed {
  static create(iframe) {
    let node = super.create();
    node.innerHTML = iframe; 
    node.iframe = iframe; 
  	console.log(node);
    return node;
  }
  static value(domNode) {
    return domNode.iframe;
  }
}

EmbedContentBlot.blotName = 'embed-content';
EmbedContentBlot.tagName = 'div';
EmbedContentBlot.className = 'embed-content';

