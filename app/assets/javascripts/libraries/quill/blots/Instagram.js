// class InstagramBlot extends BlockEmbed {
//   static create(src) {
//     var node = super.create();
//     node.dataset.src = src;
//     // Allow twitter library to modify our contents
//     createInstagramEmbed(node, src);
//     return node;
//   }

//   static value(domNode) {
//     return domNode.dataset.src;
//   }
// }

// InstagramBlot.blotName = 'instagram';
// InstagramBlot.tagName = 'div';
// InstagramBlot.className = 'instagram';

'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _get = function get(object, property, receiver) { if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { return get(parent, property, receiver); } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } };

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var InstagramBlot = function (_BlockEmbed) {
  _inherits(InstagramBlot, _BlockEmbed);

  function InstagramBlot() {
    _classCallCheck(this, InstagramBlot);

    return _possibleConstructorReturn(this, (InstagramBlot.__proto__ || Object.getPrototypeOf(InstagramBlot)).apply(this, arguments));
  }

  _createClass(InstagramBlot, null, [{
    key: 'create',
    value: function create(src) {
      var node = _get(InstagramBlot.__proto__ || Object.getPrototypeOf(InstagramBlot), 'create', this).call(this);
      node.dataset.src = src;
      // Allow twitter library to modify our contents
      createInstagramEmbed(node, src);
      return node;
    }
  }, {
    key: 'value',
    value: function value(domNode) {
      return domNode.dataset.src;
    }
  }]);

  return InstagramBlot;
}(BlockEmbed);

InstagramBlot.blotName = 'instagram';
InstagramBlot.tagName = 'div';
InstagramBlot.className = 'instagram';