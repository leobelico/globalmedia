function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["pages-panel-panel-module-js"], {
  /***/
  "./src/app/pages/panel/panel-routing.module.ts":
  /*!*****************************************************!*\
    !*** ./src/app/pages/panel/panel-routing.module.ts ***!
    \*****************************************************/

  /*! exports provided: PanelRoutingModule */

  /***/
  function srcAppPagesPanelPanelRoutingModuleTs(module, __webpack_exports__, __webpack_require__) {
    "use strict";

    __webpack_require__.r(__webpack_exports__);
    /* harmony export (binding) */


    __webpack_require__.d(__webpack_exports__, "PanelRoutingModule", function () {
      return PanelRoutingModule;
    });
    /* harmony import */


    var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
    /*! @angular/core */
    "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
    /* harmony import */


    var _angular_router__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
    /*! @angular/router */
    "./node_modules/@angular/router/__ivy_ngcc__/fesm2015/router.js");

    var routes = [{
      path: 'new-banner',
      loadChildren: function loadChildren() {
        return Promise.all(
        /*! import() | new-banner-new-banner-module */
        [__webpack_require__.e("default~new-banner-new-banner-module~preference-preference-module"), __webpack_require__.e("new-banner-new-banner-module")]).then(__webpack_require__.bind(null,
        /*! ./new-banner/new-banner.module */
        "./src/app/pages/panel/new-banner/new-banner.module.ts")).then(function (m) {
          return m.NewBannerModule;
        });
      }
    }, {
      path: 'preference',
      loadChildren: function loadChildren() {
        return Promise.all(
        /*! import() | preference-preference-module */
        [__webpack_require__.e("default~new-banner-new-banner-module~preference-preference-module"), __webpack_require__.e("preference-preference-module")]).then(__webpack_require__.bind(null,
        /*! ./preference/preference.module */
        "./src/app/pages/panel/preference/preference.module.ts")).then(function (m) {
          return m.PreferenceModule;
        });
      }
    }];

    var PanelRoutingModule = function PanelRoutingModule() {
      _classCallCheck(this, PanelRoutingModule);
    };

    PanelRoutingModule.ɵmod = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineNgModule"]({
      type: PanelRoutingModule
    });
    PanelRoutingModule.ɵinj = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjector"]({
      factory: function PanelRoutingModule_Factory(t) {
        return new (t || PanelRoutingModule)();
      },
      imports: [[_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"].forChild(routes)], _angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"]]
    });

    (function () {
      (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵsetNgModuleScope"](PanelRoutingModule, {
        imports: [_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"]],
        exports: [_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"]]
      });
    })();
    /*@__PURE__*/


    (function () {
      _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](PanelRoutingModule, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["NgModule"],
        args: [{
          imports: [_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"].forChild(routes)],
          exports: [_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"]]
        }]
      }], null, null);
    })();
    /***/

  },

  /***/
  "./src/app/pages/panel/panel.module.js":
  /*!*********************************************!*\
    !*** ./src/app/pages/panel/panel.module.js ***!
    \*********************************************/

  /*! exports provided: PanelModule */

  /***/
  function srcAppPagesPanelPanelModuleJs(module, __webpack_exports__, __webpack_require__) {
    "use strict";

    __webpack_require__.r(__webpack_exports__);
    /* harmony export (binding) */


    __webpack_require__.d(__webpack_exports__, "PanelModule", function () {
      return PanelModule;
    });
    /* harmony import */


    var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(
    /*! @angular/core */
    "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
    /* harmony import */


    var _angular_common__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(
    /*! @angular/common */
    "./node_modules/@angular/common/__ivy_ngcc__/fesm2015/common.js");
    /* harmony import */


    var _panel_routing_module__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(
    /*! ./panel-routing.module */
    "./src/app/pages/panel/panel-routing.module.ts");

    var PanelModule = function PanelModule() {
      _classCallCheck(this, PanelModule);
    };

    PanelModule.ɵmod = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineNgModule"]({
      type: PanelModule
    });
    PanelModule.ɵinj = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjector"]({
      factory: function PanelModule_Factory(t) {
        return new (t || PanelModule)();
      },
      imports: [[_angular_common__WEBPACK_IMPORTED_MODULE_1__["CommonModule"], _panel_routing_module__WEBPACK_IMPORTED_MODULE_2__["PanelRoutingModule"]]]
    });

    (function () {
      (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵsetNgModuleScope"](PanelModule, {
        imports: [_angular_common__WEBPACK_IMPORTED_MODULE_1__["CommonModule"], _panel_routing_module__WEBPACK_IMPORTED_MODULE_2__["PanelRoutingModule"]]
      });
    })();
    /*@__PURE__*/


    (function () {
      _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](PanelModule, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["NgModule"],
        args: [{
          declarations: [],
          imports: [_angular_common__WEBPACK_IMPORTED_MODULE_1__["CommonModule"], _panel_routing_module__WEBPACK_IMPORTED_MODULE_2__["PanelRoutingModule"]]
        }]
      }], null, null);
    })(); //# sourceMappingURL=panel.module.js.map

    /***/

  }
}]);
//# sourceMappingURL=pages-panel-panel-module-js-es5.js.map