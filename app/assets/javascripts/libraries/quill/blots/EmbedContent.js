// class EmbedContentBlot extends BlockEmbed {
//   static create(iframe) {
//     var node = super.create();
//     node.innerHTML = iframe; 
//     node.iframe = iframe; 
//   	console.log(node);
//     return node;
//   }
//   static value(domNode) {
//     return domNode.iframe;
//   }
// }

// EmbedContentBlot.blotName = 'embed-content';
// EmbedContentBlot.tagName = 'div';
// EmbedContentBlot.className = 'embed-content';

'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _get = function get(object, property, receiver) { if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { return get(parent, property, receiver); } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } };

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var EmbedContentBlot = function (_BlockEmbed) {
  _inherits(EmbedContentBlot, _BlockEmbed);

  function EmbedContentBlot() {
    _classCallCheck(this, EmbedContentBlot);

    return _possibleConstructorReturn(this, (EmbedContentBlot.__proto__ || Object.getPrototypeOf(EmbedContentBlot)).apply(this, arguments));
  }

  _createClass(EmbedContentBlot, null, [{
    key: 'create',
    value: function create(iframe) {
      var node = _get(EmbedContentBlot.__proto__ || Object.getPrototypeOf(EmbedContentBlot), 'create', this).call(this);
      node.innerHTML = iframe;
      node.iframe = iframe;
      console.log(node);
      return node;
    }
  }, {
    key: 'value',
    value: function value(domNode) {
      return domNode.iframe;
    }
  }]);

  return EmbedContentBlot;
}(BlockEmbed);

EmbedContentBlot.blotName = 'embed-content';
EmbedContentBlot.tagName = 'div';
EmbedContentBlot.className = 'embed-content';





