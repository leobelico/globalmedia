// var BlockEmbed = Quill.import('blots/block/embed');

// class DividerBlot extends BlockEmbed { }
// DividerBlot.blotName = 'divider';
// DividerBlot.tagName = 'hr';

// class TweetBlot extends BlockEmbed {
//   static create(id) {
//     var node = super.create();
//     node.dataset.id = id;
//     // Allow twitter library to modify our contents
//     twttr.widgets.createTweet(id, node);
//     return node;
//   }

//   static value(domNode) {
//     return domNode.dataset.id;
//   }
// }

// TweetBlot.blotName = 'tweet';
// TweetBlot.tagName = 'div';
// TweetBlot.className = 'tweet';

'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _get = function get(object, property, receiver) { if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { return get(parent, property, receiver); } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } };

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var BlockEmbed = Quill.import('blots/block/embed');

var DividerBlot = function (_BlockEmbed) {
  _inherits(DividerBlot, _BlockEmbed);

  function DividerBlot() {
    _classCallCheck(this, DividerBlot);

    return _possibleConstructorReturn(this, (DividerBlot.__proto__ || Object.getPrototypeOf(DividerBlot)).apply(this, arguments));
  }

  return DividerBlot;
}(BlockEmbed);

DividerBlot.blotName = 'divider';
DividerBlot.tagName = 'hr';

var TweetBlot = function (_BlockEmbed2) {
  _inherits(TweetBlot, _BlockEmbed2);

  function TweetBlot() {
    _classCallCheck(this, TweetBlot);

    return _possibleConstructorReturn(this, (TweetBlot.__proto__ || Object.getPrototypeOf(TweetBlot)).apply(this, arguments));
  }

  _createClass(TweetBlot, null, [{
    key: 'create',
    value: function create(id) {
      var node = _get(TweetBlot.__proto__ || Object.getPrototypeOf(TweetBlot), 'create', this).call(this);
      node.dataset.id = id;
      // Allow twitter library to modify our contents
      twttr.widgets.createTweet(id, node);
      return node;
    }
  }, {
    key: 'value',
    value: function value(domNode) {
      return domNode.dataset.id;
    }
  }]);

  return TweetBlot;
}(BlockEmbed);

TweetBlot.blotName = 'tweet';
TweetBlot.tagName = 'div';
TweetBlot.className = 'tweet';