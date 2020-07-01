(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["preference-preference-module"],{

/***/ "./src/app/models/Preference.ts":
/*!**************************************!*\
  !*** ./src/app/models/Preference.ts ***!
  \**************************************/
/*! exports provided: Preference */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "Preference", function() { return Preference; });
class Preference {
}


/***/ }),

/***/ "./src/app/pages/panel/preference/preference-routing.module.ts":
/*!*********************************************************************!*\
  !*** ./src/app/pages/panel/preference/preference-routing.module.ts ***!
  \*********************************************************************/
/*! exports provided: PreferenceRoutingModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "PreferenceRoutingModule", function() { return PreferenceRoutingModule; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/router */ "./node_modules/@angular/router/__ivy_ngcc__/fesm2015/router.js");
/* harmony import */ var _upsert_upsert_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./upsert/upsert.component */ "./src/app/pages/panel/preference/upsert/upsert.component.ts");
/* harmony import */ var _preference_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./preference.component */ "./src/app/pages/panel/preference/preference.component.ts");






const routes = [
    {
        path: '',
        component: _preference_component__WEBPACK_IMPORTED_MODULE_3__["PreferenceComponent"]
    },
    {
        path: 'create',
        component: _upsert_upsert_component__WEBPACK_IMPORTED_MODULE_2__["UpsertComponent"]
    },
    {
        path: 'edit/:id',
        component: _upsert_upsert_component__WEBPACK_IMPORTED_MODULE_2__["UpsertComponent"]
    }
];
class PreferenceRoutingModule {
}
PreferenceRoutingModule.ɵmod = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineNgModule"]({ type: PreferenceRoutingModule });
PreferenceRoutingModule.ɵinj = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjector"]({ factory: function PreferenceRoutingModule_Factory(t) { return new (t || PreferenceRoutingModule)(); }, imports: [[_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"].forChild(routes)],
        _angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"]] });
(function () { (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵsetNgModuleScope"](PreferenceRoutingModule, { imports: [_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"]], exports: [_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"]] }); })();
/*@__PURE__*/ (function () { _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](PreferenceRoutingModule, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["NgModule"],
        args: [{
                imports: [_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"].forChild(routes)],
                exports: [_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"]]
            }]
    }], null, null); })();


/***/ }),

/***/ "./src/app/pages/panel/preference/preference.component.ts":
/*!****************************************************************!*\
  !*** ./src/app/pages/panel/preference/preference.component.ts ***!
  \****************************************************************/
/*! exports provided: PreferenceComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "PreferenceComponent", function() { return PreferenceComponent; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
/* harmony import */ var _services_preference_service__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../../services/preference.service */ "./src/app/services/preference.service.ts");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/router */ "./node_modules/@angular/router/__ivy_ngcc__/fesm2015/router.js");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/common */ "./node_modules/@angular/common/__ivy_ngcc__/fesm2015/common.js");





function PreferenceComponent_tr_18_Template(rf, ctx) { if (rf & 1) {
    const _r3 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "tr");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](1, "td", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](3, "td", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](5, "td", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](6, "a", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](7, "i", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](8, "a", 13);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵlistener"]("click", function PreferenceComponent_tr_18_Template_a_click_8_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵrestoreView"](_r3); const item_r1 = ctx.$implicit; const ctx_r2 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵnextContext"](); return ctx_r2.delete(item_r1.id); });
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](9, "i", 14);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
} if (rf & 2) {
    const item_r1 = ctx.$implicit;
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate"](item_r1.key);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate"](item_r1.value);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵpropertyInterpolate1"]("routerLink", "edit/", item_r1.id, "");
} }
class PreferenceComponent {
    constructor(preferenceService) {
        this.preferenceService = preferenceService;
        this.preferences = [];
    }
    ngOnInit() {
        this.preferenceService.all().subscribe(value => {
            this.preferences = value;
        });
    }
    delete(id) {
        if (confirm('Eliminar preferencia?')) {
            this.preferenceService.delete(id).subscribe(() => {
                this.preferenceService.all().subscribe(value => {
                    this.preferences = value;
                });
            });
        }
    }
}
PreferenceComponent.ɵfac = function PreferenceComponent_Factory(t) { return new (t || PreferenceComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_services_preference_service__WEBPACK_IMPORTED_MODULE_1__["PreferenceService"])); };
PreferenceComponent.ɵcmp = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineComponent"]({ type: PreferenceComponent, selectors: [["app-preference"]], decls: 19, vars: 1, consts: [[1, "row", "mt-2"], [1, "col-12", "d-flex", "justify-content-start"], [1, "col-12", "d-flex", "justify-content-end"], ["routerLink", "create", 1, "btn", "btn-sm", "btn-primary"], [1, "col-12"], [1, "table", "table-sm"], [1, "thead-dark"], ["scope", "col", 1, "text-center"], [4, "ngFor", "ngForOf"], [1, "text-center"], [1, "d-flex", "justify-content-center"], [3, "routerLink"], [1, "mx-1", "fas", "fa-edit", "text-secondary"], [2, "cursor", "pointer", 3, "click"], [1, "mx-1", "fas", "fa-trash", "text-danger"]], template: function PreferenceComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "div", 0);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](1, "div", 1);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](2, "h2");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](3, "Banners");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](4, "div", 2);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](5, "button", 3);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](6, "Agregar");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](7, "div", 4);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](8, "table", 5);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](9, "thead", 6);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](10, "tr");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](11, "th", 7);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](12, "Key");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](13, "th", 7);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](14, "Value");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](15, "th", 7);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](16, "Acciones");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](17, "tbody");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](18, PreferenceComponent_tr_18_Template, 10, 3, "tr", 8);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](18);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngForOf", ctx.preferences);
    } }, directives: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterLink"], _angular_common__WEBPACK_IMPORTED_MODULE_3__["NgForOf"], _angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterLinkWithHref"]], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJzcmMvYXBwL3BhZ2VzL3BhbmVsL3ByZWZlcmVuY2UvcHJlZmVyZW5jZS5jb21wb25lbnQuc2NzcyJ9 */"] });
/*@__PURE__*/ (function () { _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](PreferenceComponent, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"],
        args: [{
                selector: 'app-preference',
                templateUrl: './preference.component.html',
                styleUrls: ['./preference.component.scss']
            }]
    }], function () { return [{ type: _services_preference_service__WEBPACK_IMPORTED_MODULE_1__["PreferenceService"] }]; }, null); })();


/***/ }),

/***/ "./src/app/pages/panel/preference/preference.module.ts":
/*!*************************************************************!*\
  !*** ./src/app/pages/panel/preference/preference.module.ts ***!
  \*************************************************************/
/*! exports provided: PreferenceModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "PreferenceModule", function() { return PreferenceModule; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/common */ "./node_modules/@angular/common/__ivy_ngcc__/fesm2015/common.js");
/* harmony import */ var _preference_routing_module__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./preference-routing.module */ "./src/app/pages/panel/preference/preference-routing.module.ts");
/* harmony import */ var _preference_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./preference.component */ "./src/app/pages/panel/preference/preference.component.ts");
/* harmony import */ var _upsert_upsert_component__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ./upsert/upsert.component */ "./src/app/pages/panel/preference/upsert/upsert.component.ts");
/* harmony import */ var _services_preference_service__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ../../../services/preference.service */ "./src/app/services/preference.service.ts");
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @angular/forms */ "./node_modules/@angular/forms/__ivy_ngcc__/fesm2015/forms.js");








class PreferenceModule {
}
PreferenceModule.ɵmod = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineNgModule"]({ type: PreferenceModule });
PreferenceModule.ɵinj = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjector"]({ factory: function PreferenceModule_Factory(t) { return new (t || PreferenceModule)(); }, providers: [_services_preference_service__WEBPACK_IMPORTED_MODULE_5__["PreferenceService"]], imports: [[
            _angular_common__WEBPACK_IMPORTED_MODULE_1__["CommonModule"],
            _preference_routing_module__WEBPACK_IMPORTED_MODULE_2__["PreferenceRoutingModule"],
            _angular_forms__WEBPACK_IMPORTED_MODULE_6__["ReactiveFormsModule"]
        ]] });
(function () { (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵsetNgModuleScope"](PreferenceModule, { declarations: [_preference_component__WEBPACK_IMPORTED_MODULE_3__["PreferenceComponent"], _upsert_upsert_component__WEBPACK_IMPORTED_MODULE_4__["UpsertComponent"]], imports: [_angular_common__WEBPACK_IMPORTED_MODULE_1__["CommonModule"],
        _preference_routing_module__WEBPACK_IMPORTED_MODULE_2__["PreferenceRoutingModule"],
        _angular_forms__WEBPACK_IMPORTED_MODULE_6__["ReactiveFormsModule"]], exports: [_preference_component__WEBPACK_IMPORTED_MODULE_3__["PreferenceComponent"], _upsert_upsert_component__WEBPACK_IMPORTED_MODULE_4__["UpsertComponent"]] }); })();
/*@__PURE__*/ (function () { _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](PreferenceModule, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["NgModule"],
        args: [{
                declarations: [_preference_component__WEBPACK_IMPORTED_MODULE_3__["PreferenceComponent"], _upsert_upsert_component__WEBPACK_IMPORTED_MODULE_4__["UpsertComponent"]],
                imports: [
                    _angular_common__WEBPACK_IMPORTED_MODULE_1__["CommonModule"],
                    _preference_routing_module__WEBPACK_IMPORTED_MODULE_2__["PreferenceRoutingModule"],
                    _angular_forms__WEBPACK_IMPORTED_MODULE_6__["ReactiveFormsModule"]
                ],
                exports: [_preference_component__WEBPACK_IMPORTED_MODULE_3__["PreferenceComponent"], _upsert_upsert_component__WEBPACK_IMPORTED_MODULE_4__["UpsertComponent"]],
                providers: [_services_preference_service__WEBPACK_IMPORTED_MODULE_5__["PreferenceService"]]
            }]
    }], null, null); })();


/***/ }),

/***/ "./src/app/pages/panel/preference/upsert/upsert.component.ts":
/*!*******************************************************************!*\
  !*** ./src/app/pages/panel/preference/upsert/upsert.component.ts ***!
  \*******************************************************************/
/*! exports provided: UpsertComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "UpsertComponent", function() { return UpsertComponent; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/forms */ "./node_modules/@angular/forms/__ivy_ngcc__/fesm2015/forms.js");
/* harmony import */ var _models_Preference__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../models/Preference */ "./src/app/models/Preference.ts");
/* harmony import */ var _services_preference_service__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ../../../../services/preference.service */ "./src/app/services/preference.service.ts");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/router */ "./node_modules/@angular/router/__ivy_ngcc__/fesm2015/router.js");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/common */ "./node_modules/@angular/common/__ivy_ngcc__/fesm2015/common.js");








function UpsertComponent_div_1_Template(rf, ctx) { if (rf & 1) {
    const _r2 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "div", 2);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵlistener"]("submit", function UpsertComponent_div_1_Template_div_submit_0_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵrestoreView"](_r2); const ctx_r1 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵnextContext"](); return ctx_r1.onSubmit(); });
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](1, "form", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](2, "div", 0);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](3, "div", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](4, "h3");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](5, "Preferencia");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](6, "div", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](7, "label", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](8, "Key");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](9, "input", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](10, "div", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](11, "label", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](12, "Value");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](13, "input", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](14, "div", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](15, "button", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](16, "Guardar");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
} if (rf & 2) {
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("formGroup", ctx_r0.formGroupUpsert);
} }
class UpsertComponent {
    constructor(preferenceService, router, activatedRoute) {
        this.preferenceService = preferenceService;
        this.router = router;
        this.activatedRoute = activatedRoute;
        this.updateId = null;
    }
    ngOnInit() {
        const updateId = this.activatedRoute.snapshot.params['id'];
        if (updateId) {
            this.updateId = updateId;
            this.preferenceService.find(updateId).subscribe(value => {
                this.formGroupUpsert = new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormGroup"]({
                    key: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"](value.key, [_angular_forms__WEBPACK_IMPORTED_MODULE_1__["Validators"].required]),
                    value: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"](value.value),
                });
            });
        }
        else {
            this.formGroupUpsert = new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormGroup"]({
                key: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"](null, [_angular_forms__WEBPACK_IMPORTED_MODULE_1__["Validators"].required]),
                value: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"](null),
            });
        }
    }
    onSubmit() {
        for (const i in this.formGroupUpsert.controls) {
            this.formGroupUpsert.controls[i].markAsDirty();
            this.formGroupUpsert.controls[i].updateValueAndValidity();
        }
        if (this.formGroupUpsert.invalid) {
            return;
        }
        const newBanner = new _models_Preference__WEBPACK_IMPORTED_MODULE_2__["Preference"]();
        newBanner.key = this.formGroupUpsert.controls['key'].value;
        newBanner.value = this.formGroupUpsert.controls['value'].value;
        if (this.updateId) {
            this.preferenceService.update(this.updateId, newBanner).subscribe(value => {
                this.router.navigate(['/panel/preference']);
            });
        }
        else {
            this.preferenceService.create(newBanner).subscribe(value => {
                this.router.navigate(['/panel/preference']);
            });
        }
    }
}
UpsertComponent.ɵfac = function UpsertComponent_Factory(t) { return new (t || UpsertComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_services_preference_service__WEBPACK_IMPORTED_MODULE_3__["PreferenceService"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_4__["ActivatedRoute"])); };
UpsertComponent.ɵcmp = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineComponent"]({ type: UpsertComponent, selectors: [["app-upsert"]], decls: 2, vars: 1, consts: [[1, "row"], ["class", "col-12 card", 3, "submit", 4, "ngIf"], [1, "col-12", "card", 3, "submit"], [3, "formGroup"], [1, "col-12"], [1, "form-group", "col-12", "col-md-6"], ["for", "inputKey"], ["formControlName", "key", "type", "text", "id", "inputKey", "placeholder", "Key", 1, "form-control", "form-control-sm"], ["for", "inputValue"], ["type", "text", "formControlName", "value", "id", "inputValue", "placeholder", "Value", 1, "form-control", "form-control-sm"], [1, "col-12", "d-flex", "justify-content-end", 2, "margin-top", "150px"], ["type", "submit", 1, "btn", "btn-sm", "btn-primary", "my-2"]], template: function UpsertComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "div", 0);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](1, UpsertComponent_div_1_Template, 17, 1, "div", 1);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](1);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", ctx.formGroupUpsert);
    } }, directives: [_angular_common__WEBPACK_IMPORTED_MODULE_5__["NgIf"], _angular_forms__WEBPACK_IMPORTED_MODULE_1__["ɵangular_packages_forms_forms_y"], _angular_forms__WEBPACK_IMPORTED_MODULE_1__["NgControlStatusGroup"], _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormGroupDirective"], _angular_forms__WEBPACK_IMPORTED_MODULE_1__["DefaultValueAccessor"], _angular_forms__WEBPACK_IMPORTED_MODULE_1__["NgControlStatus"], _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControlName"]], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJzcmMvYXBwL3BhZ2VzL3BhbmVsL3ByZWZlcmVuY2UvdXBzZXJ0L3Vwc2VydC5jb21wb25lbnQuc2NzcyJ9 */"] });
/*@__PURE__*/ (function () { _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](UpsertComponent, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"],
        args: [{
                selector: 'app-upsert',
                templateUrl: './upsert.component.html',
                styleUrls: ['./upsert.component.scss']
            }]
    }], function () { return [{ type: _services_preference_service__WEBPACK_IMPORTED_MODULE_3__["PreferenceService"] }, { type: _angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"] }, { type: _angular_router__WEBPACK_IMPORTED_MODULE_4__["ActivatedRoute"] }]; }, null); })();


/***/ }),

/***/ "./src/app/services/preference.service.ts":
/*!************************************************!*\
  !*** ./src/app/services/preference.service.ts ***!
  \************************************************/
/*! exports provided: PreferenceService */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "PreferenceService", function() { return PreferenceService; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
/* harmony import */ var _base_endpoint_service__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./base-endpoint.service */ "./src/app/services/base-endpoint.service.ts");
/* harmony import */ var rxjs_operators__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! rxjs/operators */ "./node_modules/rxjs/_esm2015/operators/index.js");
/* harmony import */ var moment__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! moment */ "./node_modules/moment/moment.js");
/* harmony import */ var moment__WEBPACK_IMPORTED_MODULE_3___default = /*#__PURE__*/__webpack_require__.n(moment__WEBPACK_IMPORTED_MODULE_3__);
/* harmony import */ var _angular_common_http__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/common/http */ "./node_modules/@angular/common/__ivy_ngcc__/fesm2015/http.js");






class PreferenceService extends _base_endpoint_service__WEBPACK_IMPORTED_MODULE_1__["BaseEndpointService"] {
    constructor(httpClient) {
        super(httpClient);
    }
    all() {
        const url = `${this.apiUrl}/preferences`;
        return this.httpClient.get(url, this.getHeaders()).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["catchError"])(err => this.handleError(err)), Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["map"])(value => {
            for (let i = 0; i < value.length; i++) {
                value[i].created_at = moment__WEBPACK_IMPORTED_MODULE_3__(value[i].created_at).toDate();
                value[i].updated_at = moment__WEBPACK_IMPORTED_MODULE_3__(value[i].updated_at).toDate();
            }
            return value;
        }));
    }
    find(id) {
        const url = `${this.apiUrl}/preference/${id}`;
        return this.httpClient.get(url, this.getHeaders()).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["catchError"])(err => this.handleError(err)), Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["map"])(value => {
            if (value) {
                value.created_at = moment__WEBPACK_IMPORTED_MODULE_3__(value.created_at).toDate();
                value.updated_at = moment__WEBPACK_IMPORTED_MODULE_3__(value.updated_at).toDate();
            }
            return value;
        }));
    }
    create(request) {
        const url = `${this.apiUrl}/preference`;
        return this.httpClient.post(url, request, this.getHeaders()).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["catchError"])(err => this.handleError(err)), Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["map"])(value => {
            if (value) {
                value.created_at = moment__WEBPACK_IMPORTED_MODULE_3__(value.created_at).toDate();
                value.updated_at = moment__WEBPACK_IMPORTED_MODULE_3__(value.updated_at).toDate();
            }
            return value;
        }));
    }
    update(id, request) {
        const url = `${this.apiUrl}/preference/${id}`;
        return this.httpClient.post(url, request, this.getHeaders()).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["catchError"])(err => this.handleError(err)), Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["map"])(value => {
            if (value) {
                value.created_at = moment__WEBPACK_IMPORTED_MODULE_3__(value.created_at).toDate();
                value.updated_at = moment__WEBPACK_IMPORTED_MODULE_3__(value.updated_at).toDate();
            }
            return value;
        }));
    }
    delete(id) {
        const url = `${this.apiUrl}/preference/${id}`;
        return this.httpClient.delete(url, this.getHeaders()).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["catchError"])(err => this.handleError(err)), Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["map"])(value => {
            if (value) {
                value.created_at = moment__WEBPACK_IMPORTED_MODULE_3__(value.created_at).toDate();
                value.updated_at = moment__WEBPACK_IMPORTED_MODULE_3__(value.updated_at).toDate();
            }
            return value;
        }));
    }
}
PreferenceService.ɵfac = function PreferenceService_Factory(t) { return new (t || PreferenceService)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵinject"](_angular_common_http__WEBPACK_IMPORTED_MODULE_4__["HttpClient"])); };
PreferenceService.ɵprov = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjectable"]({ token: PreferenceService, factory: PreferenceService.ɵfac });
/*@__PURE__*/ (function () { _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](PreferenceService, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Injectable"]
    }], function () { return [{ type: _angular_common_http__WEBPACK_IMPORTED_MODULE_4__["HttpClient"] }]; }, null); })();


/***/ })

}]);
//# sourceMappingURL=preference-preference-module-es2015.js.map