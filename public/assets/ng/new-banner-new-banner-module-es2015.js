(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["new-banner-new-banner-module"],{

/***/ "./node_modules/ngx-quill/__ivy_ngcc__/fesm2015/ngx-quill.js":
/*!*******************************************************************!*\
  !*** ./node_modules/ngx-quill/__ivy_ngcc__/fesm2015/ngx-quill.js ***!
  \*******************************************************************/
/*! exports provided: QUILL_CONFIG_TOKEN, QuillEditorBase, QuillEditorComponent, QuillModule, QuillService, QuillViewComponent, QuillViewHTMLComponent, defaultModules */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "QUILL_CONFIG_TOKEN", function() { return QUILL_CONFIG_TOKEN; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "QuillEditorBase", function() { return QuillEditorBase; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "QuillEditorComponent", function() { return QuillEditorComponent; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "QuillModule", function() { return QuillModule; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "QuillService", function() { return QuillService; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "QuillViewComponent", function() { return QuillViewComponent; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "QuillViewHTMLComponent", function() { return QuillViewHTMLComponent; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "defaultModules", function() { return defaultModules; });
/* harmony import */ var tslib__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! tslib */ "./node_modules/tslib/tslib.es6.js");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/common */ "./node_modules/@angular/common/__ivy_ngcc__/fesm2015/common.js");
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
/* harmony import */ var _angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/platform-browser */ "./node_modules/@angular/platform-browser/__ivy_ngcc__/fesm2015/platform-browser.js");
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/forms */ "./node_modules/@angular/forms/__ivy_ngcc__/fesm2015/forms.js");










const _c0 = [[["", "quill-editor-toolbar", ""]]];
const _c1 = ["[quill-editor-toolbar]"];
const defaultModules = {
    toolbar: [
        ['bold', 'italic', 'underline', 'strike'],
        ['blockquote', 'code-block'],
        [{ header: 1 }, { header: 2 }],
        [{ list: 'ordered' }, { list: 'bullet' }],
        [{ script: 'sub' }, { script: 'super' }],
        [{ indent: '-1' }, { indent: '+1' }],
        [{ direction: 'rtl' }],
        [{ size: ['small', false, 'large', 'huge'] }],
        [{ header: [1, 2, 3, 4, 5, 6, false] }],
        [
            { color: [] },
            { background: [] }
        ],
        [{ font: [] }],
        [{ align: [] }],
        ['clean'],
        ['link', 'image', 'video'] // link and image, video
    ]
};

const getFormat = (format, configFormat) => {
    const passedFormat = format || configFormat;
    return passedFormat || 'html';
};

const QUILL_CONFIG_TOKEN = new _angular_core__WEBPACK_IMPORTED_MODULE_2__["InjectionToken"]('config');

let QuillService = class QuillService {
    constructor(config) {
        this.config = config;
        this.count = 0;
        if (!this.config) {
            this.config = { modules: defaultModules };
        }
    }
    getQuill() {
        this.count++;
        if (!this.Quill && this.count === 1) {
            this.$importPromise = new Promise((resolve) => Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__awaiter"])(this, void 0, void 0, function* () {
                var _a, _b;
                const quillImport = yield __webpack_require__.e(/*! import() | quill */ "quill").then(__webpack_require__.t.bind(null, /*! quill */ "./node_modules/quill/dist/quill.js", 7));
                this.Quill = (quillImport.default ? quillImport.default : quillImport);
                // Only register custom options and modules once
                (_a = this.config.customOptions) === null || _a === void 0 ? void 0 : _a.forEach((customOption) => {
                    const newCustomOption = this.Quill.import(customOption.import);
                    newCustomOption.whitelist = customOption.whitelist;
                    this.Quill.register(newCustomOption, true, this.config.suppressGlobalRegisterWarning);
                });
                (_b = this.config.customModules) === null || _b === void 0 ? void 0 : _b.forEach(({ implementation, path }) => {
                    this.Quill.register(path, implementation, this.config.suppressGlobalRegisterWarning);
                });
                resolve(this.Quill);
            }));
        }
        return this.$importPromise;
    }
};
QuillService.ɵfac = function QuillService_Factory(t) { return new (t || QuillService)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵinject"](QUILL_CONFIG_TOKEN)); };
QuillService.ctorParameters = () => [
    { type: undefined, decorators: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"], args: [QUILL_CONFIG_TOKEN,] }] }
];
QuillService.ɵprov = Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineInjectable"])({ factory: function QuillService_Factory() { return new QuillService(Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵinject"])(QUILL_CONFIG_TOKEN)); }, token: QuillService, providedIn: "root" });
QuillService = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([ Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__param"])(0, Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"])(QUILL_CONFIG_TOKEN))
], QuillService);

var QuillEditorBase_1, QuillEditorComponent_1;
let QuillEditorBase = QuillEditorBase_1 = 
// tslint:disable-next-line:directive-class-suffix
class QuillEditorBase {
    constructor(elementRef, domSanitizer, doc, platformId, renderer, zone, service) {
        this.elementRef = elementRef;
        this.domSanitizer = domSanitizer;
        this.doc = doc;
        this.platformId = platformId;
        this.renderer = renderer;
        this.zone = zone;
        this.service = service;
        this.required = false;
        this.customToolbarPosition = 'top';
        this.sanitize = false;
        this.styles = null;
        this.strict = true;
        this.customOptions = [];
        this.customModules = [];
        this.preserveWhitespace = false;
        this.trimOnValidation = false;
        this.onEditorCreated = new _angular_core__WEBPACK_IMPORTED_MODULE_2__["EventEmitter"]();
        this.onEditorChanged = new _angular_core__WEBPACK_IMPORTED_MODULE_2__["EventEmitter"]();
        this.onContentChanged = new _angular_core__WEBPACK_IMPORTED_MODULE_2__["EventEmitter"]();
        this.onSelectionChanged = new _angular_core__WEBPACK_IMPORTED_MODULE_2__["EventEmitter"]();
        this.onFocus = new _angular_core__WEBPACK_IMPORTED_MODULE_2__["EventEmitter"]();
        this.onBlur = new _angular_core__WEBPACK_IMPORTED_MODULE_2__["EventEmitter"]();
        this.disabled = false; // used to store initial value before ViewInit
        this.valueGetter = (quillEditor, editorElement) => {
            let html = editorElement.querySelector('.ql-editor').innerHTML;
            if (html === '<p><br></p>' || html === '<div><br></div>') {
                html = null;
            }
            let modelValue = html;
            const format = getFormat(this.format, this.service.config.format);
            if (format === 'text') {
                modelValue = quillEditor.getText();
            }
            else if (format === 'object') {
                modelValue = quillEditor.getContents();
            }
            else if (format === 'json') {
                try {
                    modelValue = JSON.stringify(quillEditor.getContents());
                }
                catch (e) {
                    modelValue = quillEditor.getText();
                }
            }
            return modelValue;
        };
        this.valueSetter = (quillEditor, value) => {
            const format = getFormat(this.format, this.service.config.format);
            if (format === 'html') {
                if (this.sanitize) {
                    value = this.domSanitizer.sanitize(_angular_core__WEBPACK_IMPORTED_MODULE_2__["SecurityContext"].HTML, value);
                }
                return quillEditor.clipboard.convert(value);
            }
            else if (format === 'json') {
                try {
                    return JSON.parse(value);
                }
                catch (e) {
                    return [{ insert: value }];
                }
            }
            return value;
        };
        this.selectionChangeHandler = (range, oldRange, source) => {
            const shouldTriggerOnModelTouched = !range && !!this.onModelTouched;
            // only emit changes when there's any listener
            if (!this.onBlur.observers.length &&
                !this.onFocus.observers.length &&
                !this.onSelectionChanged.observers.length &&
                !shouldTriggerOnModelTouched) {
                return;
            }
            this.zone.run(() => {
                if (range === null) {
                    this.onBlur.emit({
                        editor: this.quillEditor,
                        source
                    });
                }
                else if (oldRange === null) {
                    this.onFocus.emit({
                        editor: this.quillEditor,
                        source
                    });
                }
                this.onSelectionChanged.emit({
                    editor: this.quillEditor,
                    oldRange,
                    range,
                    source
                });
                if (shouldTriggerOnModelTouched) {
                    this.onModelTouched();
                }
            });
        };
        this.textChangeHandler = (delta, oldDelta, source) => {
            // only emit changes emitted by user interactions
            const text = this.quillEditor.getText();
            const content = this.quillEditor.getContents();
            let html = this.editorElem.querySelector('.ql-editor').innerHTML;
            if (html === '<p><br></p>' || html === '<div><br></div>') {
                html = null;
            }
            const trackChanges = this.trackChanges || this.service.config.trackChanges;
            const shouldTriggerOnModelChange = (source === 'user' || trackChanges && trackChanges === 'all') && !!this.onModelChange;
            // only emit changes when there's any listener
            if (!this.onContentChanged.observers.length && !shouldTriggerOnModelChange) {
                return;
            }
            this.zone.run(() => {
                if (shouldTriggerOnModelChange) {
                    this.onModelChange(this.valueGetter(this.quillEditor, this.editorElem));
                }
                this.onContentChanged.emit({
                    content,
                    delta,
                    editor: this.quillEditor,
                    html,
                    oldDelta,
                    source,
                    text
                });
            });
        };
        // tslint:disable-next-line:max-line-length
        this.editorChangeHandler = (event, current, old, source) => {
            // only emit changes when there's any listener
            if (!this.onEditorChanged.observers.length) {
                return;
            }
            // only emit changes emitted by user interactions
            if (event === 'text-change') {
                const text = this.quillEditor.getText();
                const content = this.quillEditor.getContents();
                let html = this.editorElem.querySelector('.ql-editor').innerHTML;
                if (html === '<p><br></p>' || html === '<div><br></div>') {
                    html = null;
                }
                this.zone.run(() => {
                    this.onEditorChanged.emit({
                        content,
                        delta: current,
                        editor: this.quillEditor,
                        event,
                        html,
                        oldDelta: old,
                        source,
                        text
                    });
                });
            }
            else {
                this.onEditorChanged.emit({
                    editor: this.quillEditor,
                    event,
                    oldRange: old,
                    range: current,
                    source
                });
            }
        };
    }
    static normalizeClassNames(classes) {
        const classList = classes.trim().split(' ');
        return classList.reduce((prev, cur) => {
            const trimmed = cur.trim();
            if (trimmed) {
                prev.push(trimmed);
            }
            return prev;
        }, []);
    }
    ngAfterViewInit() {
        return Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__awaiter"])(this, void 0, void 0, function* () {
            if (Object(_angular_common__WEBPACK_IMPORTED_MODULE_1__["isPlatformServer"])(this.platformId)) {
                return;
            }
            const Quill = yield this.service.getQuill();
            this.elementRef.nativeElement.insertAdjacentHTML(this.customToolbarPosition === 'top' ? 'beforeend' : 'afterbegin', this.preserveWhitespace ? '<pre quill-editor-element></pre>' : '<div quill-editor-element></div>');
            this.editorElem = this.elementRef.nativeElement.querySelector('[quill-editor-element]');
            const toolbarElem = this.elementRef.nativeElement.querySelector('[quill-editor-toolbar]');
            const modules = Object.assign({}, this.modules || this.service.config.modules);
            if (toolbarElem) {
                modules.toolbar = toolbarElem;
            }
            else if (modules.toolbar === undefined) {
                modules.toolbar = defaultModules.toolbar;
            }
            let placeholder = this.placeholder !== undefined ? this.placeholder : this.service.config.placeholder;
            if (placeholder === undefined) {
                placeholder = 'Insert text here ...';
            }
            if (this.styles) {
                Object.keys(this.styles).forEach((key) => {
                    this.renderer.setStyle(this.editorElem, key, this.styles[key]);
                });
            }
            if (this.classes) {
                this.addClasses(this.classes);
            }
            this.customOptions.forEach((customOption) => {
                const newCustomOption = Quill.import(customOption.import);
                newCustomOption.whitelist = customOption.whitelist;
                Quill.register(newCustomOption, true);
            });
            this.customModules.forEach(({ implementation, path }) => {
                Quill.register(path, implementation);
            });
            let bounds = this.bounds && this.bounds === 'self' ? this.editorElem : this.bounds;
            if (!bounds) {
                bounds = this.service.config.bounds ? this.service.config.bounds : this.doc.body;
            }
            let debug = this.debug;
            if (!debug && debug !== false && this.service.config.debug) {
                debug = this.service.config.debug;
            }
            let readOnly = this.readOnly;
            if (!readOnly && this.readOnly !== false) {
                readOnly = this.service.config.readOnly !== undefined ? this.service.config.readOnly : false;
            }
            let scrollingContainer = this.scrollingContainer;
            if (!scrollingContainer && this.scrollingContainer !== null) {
                scrollingContainer =
                    this.service.config.scrollingContainer === null
                        || this.service.config.scrollingContainer ? this.service.config.scrollingContainer : null;
            }
            let formats = this.formats;
            if (!formats && formats === undefined) {
                formats = this.service.config.formats ? [...this.service.config.formats] : (this.service.config.formats === null ? null : undefined);
            }
            this.zone.runOutsideAngular(() => {
                this.quillEditor = new Quill(this.editorElem, {
                    bounds,
                    debug: debug,
                    formats: formats,
                    modules,
                    placeholder,
                    readOnly,
                    scrollingContainer: scrollingContainer,
                    strict: this.strict,
                    theme: this.theme || (this.service.config.theme ? this.service.config.theme : 'snow')
                });
            });
            if (this.content) {
                const format = getFormat(this.format, this.service.config.format);
                if (format === 'object') {
                    this.quillEditor.setContents(this.content, 'silent');
                }
                else if (format === 'text') {
                    this.quillEditor.setText(this.content, 'silent');
                }
                else if (format === 'json') {
                    try {
                        this.quillEditor.setContents(JSON.parse(this.content), 'silent');
                    }
                    catch (e) {
                        this.quillEditor.setText(this.content, 'silent');
                    }
                }
                else {
                    if (this.sanitize) {
                        this.content = this.domSanitizer.sanitize(_angular_core__WEBPACK_IMPORTED_MODULE_2__["SecurityContext"].HTML, this.content);
                    }
                    const contents = this.quillEditor.clipboard.convert(this.content);
                    this.quillEditor.setContents(contents, 'silent');
                }
                this.quillEditor.getModule('history').clear();
            }
            // initialize disabled status based on this.disabled as default value
            this.setDisabledState();
            // triggered if selection or text changed
            this.quillEditor.on('editor-change', this.editorChangeHandler);
            // mark model as touched if editor lost focus
            this.quillEditor.on('selection-change', this.selectionChangeHandler);
            // update model if text changes
            this.quillEditor.on('text-change', this.textChangeHandler);
            // trigger created in a timeout to avoid changed models after checked
            // if you are using the editor api in created output to change the editor content
            setTimeout(() => {
                if (this.onValidatorChanged) {
                    this.onValidatorChanged();
                }
                this.onEditorCreated.emit(this.quillEditor);
            });
        });
    }
    ngOnDestroy() {
        if (this.quillEditor) {
            this.quillEditor.off('selection-change', this.selectionChangeHandler);
            this.quillEditor.off('text-change', this.textChangeHandler);
            this.quillEditor.off('editor-change', this.editorChangeHandler);
        }
    }
    ngOnChanges(changes) {
        if (!this.quillEditor) {
            return;
        }
        // tslint:disable:no-string-literal
        if (changes['readOnly']) {
            this.quillEditor.enable(!changes['readOnly'].currentValue);
        }
        if (changes['placeholder']) {
            this.quillEditor.root.dataset.placeholder =
                changes['placeholder'].currentValue;
        }
        if (changes['styles']) {
            const currentStyling = changes['styles'].currentValue;
            const previousStyling = changes['styles'].previousValue;
            if (previousStyling) {
                Object.keys(previousStyling).forEach((key) => {
                    this.renderer.removeStyle(this.editorElem, key);
                });
            }
            if (currentStyling) {
                Object.keys(currentStyling).forEach((key) => {
                    this.renderer.setStyle(this.editorElem, key, this.styles[key]);
                });
            }
        }
        if (changes['classes']) {
            const currentClasses = changes['classes'].currentValue;
            const previousClasses = changes['classes'].previousValue;
            if (previousClasses) {
                this.removeClasses(previousClasses);
            }
            if (currentClasses) {
                this.addClasses(currentClasses);
            }
        }
        // tslint:enable:no-string-literal
    }
    addClasses(classList) {
        QuillEditorBase_1.normalizeClassNames(classList).forEach((c) => {
            this.renderer.addClass(this.editorElem, c);
        });
    }
    removeClasses(classList) {
        QuillEditorBase_1.normalizeClassNames(classList).forEach((c) => {
            this.renderer.removeClass(this.editorElem, c);
        });
    }
    writeValue(currentValue) {
        this.content = currentValue;
        const format = getFormat(this.format, this.service.config.format);
        if (this.quillEditor) {
            if (currentValue) {
                if (format === 'text') {
                    this.quillEditor.setText(currentValue);
                }
                else {
                    this.quillEditor.setContents(this.valueSetter(this.quillEditor, this.content));
                }
                return;
            }
            this.quillEditor.setText('');
        }
    }
    setDisabledState(isDisabled = this.disabled) {
        // store initial value to set appropriate disabled status after ViewInit
        this.disabled = isDisabled;
        if (this.quillEditor) {
            if (isDisabled) {
                this.quillEditor.disable();
                this.renderer.setAttribute(this.elementRef.nativeElement, 'disabled', 'disabled');
            }
            else {
                if (!this.readOnly) {
                    this.quillEditor.enable();
                }
                this.renderer.removeAttribute(this.elementRef.nativeElement, 'disabled');
            }
        }
    }
    registerOnChange(fn) {
        this.onModelChange = fn;
    }
    registerOnTouched(fn) {
        this.onModelTouched = fn;
    }
    registerOnValidatorChange(fn) {
        this.onValidatorChanged = fn;
    }
    validate() {
        if (!this.quillEditor) {
            return null;
        }
        const err = {};
        let valid = true;
        const text = this.quillEditor.getText();
        // trim text if wanted + handle special case that an empty editor contains a new line
        const textLength = this.trimOnValidation ? text.trim().length : (text.length === 1 && text.trim().length === 0 ? 0 : text.length - 1);
        if (this.minLength && textLength && textLength < this.minLength) {
            err.minLengthError = {
                given: textLength,
                minLength: this.minLength
            };
            valid = false;
        }
        if (this.maxLength && textLength > this.maxLength) {
            err.maxLengthError = {
                given: textLength,
                maxLength: this.maxLength
            };
            valid = false;
        }
        if (this.required && !textLength) {
            err.requiredError = {
                empty: true
            };
            valid = false;
        }
        return valid ? null : err;
    }
};
QuillEditorBase.ɵfac = function QuillEditorBase_Factory(t) { return new (t || QuillEditorBase)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_2__["ElementRef"]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__["DomSanitizer"]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_common__WEBPACK_IMPORTED_MODULE_1__["DOCUMENT"]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_2__["PLATFORM_ID"]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_2__["Renderer2"]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_2__["NgZone"]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](QuillService)); };
QuillEditorBase.ɵdir = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineDirective"]({ type: QuillEditorBase, inputs: { required: "required", customToolbarPosition: "customToolbarPosition", sanitize: "sanitize", styles: "styles", strict: "strict", customOptions: "customOptions", customModules: "customModules", preserveWhitespace: "preserveWhitespace", trimOnValidation: "trimOnValidation", valueGetter: "valueGetter", valueSetter: "valueSetter", format: "format", theme: "theme", modules: "modules", debug: "debug", readOnly: "readOnly", placeholder: "placeholder", maxLength: "maxLength", minLength: "minLength", formats: "formats", scrollingContainer: "scrollingContainer", bounds: "bounds", trackChanges: "trackChanges", classes: "classes" }, outputs: { onEditorCreated: "onEditorCreated", onEditorChanged: "onEditorChanged", onContentChanged: "onContentChanged", onSelectionChanged: "onSelectionChanged", onFocus: "onFocus", onBlur: "onBlur" }, features: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵNgOnChangesFeature"]] });
QuillEditorBase.ctorParameters = () => [
    { type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["ElementRef"] },
    { type: _angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__["DomSanitizer"] },
    { type: undefined, decorators: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"], args: [_angular_common__WEBPACK_IMPORTED_MODULE_1__["DOCUMENT"],] }] },
    { type: undefined, decorators: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"], args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["PLATFORM_ID"],] }] },
    { type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Renderer2"] },
    { type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["NgZone"] },
    { type: QuillService }
];
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "format", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "theme", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "modules", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "debug", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "readOnly", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "placeholder", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "maxLength", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "minLength", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "required", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "formats", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "customToolbarPosition", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "sanitize", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "styles", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "strict", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "scrollingContainer", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "bounds", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "customOptions", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "customModules", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "trackChanges", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "preserveWhitespace", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "classes", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "trimOnValidation", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Output"])()
], QuillEditorBase.prototype, "onEditorCreated", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Output"])()
], QuillEditorBase.prototype, "onEditorChanged", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Output"])()
], QuillEditorBase.prototype, "onContentChanged", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Output"])()
], QuillEditorBase.prototype, "onSelectionChanged", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Output"])()
], QuillEditorBase.prototype, "onFocus", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Output"])()
], QuillEditorBase.prototype, "onBlur", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "valueGetter", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillEditorBase.prototype, "valueSetter", void 0);
QuillEditorBase = QuillEditorBase_1 = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([ Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__param"])(2, Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"])(_angular_common__WEBPACK_IMPORTED_MODULE_1__["DOCUMENT"])),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__param"])(3, Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"])(_angular_core__WEBPACK_IMPORTED_MODULE_2__["PLATFORM_ID"]))
], QuillEditorBase);
let QuillEditorComponent = QuillEditorComponent_1 = class QuillEditorComponent extends QuillEditorBase {
    constructor(elementRef, domSanitizer, doc, platformId, renderer, zone, service) {
        super(elementRef, domSanitizer, doc, platformId, renderer, zone, service);
    }
};
QuillEditorComponent.ɵfac = function QuillEditorComponent_Factory(t) { return new (t || QuillEditorComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_2__["ElementRef"]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__["DomSanitizer"]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_common__WEBPACK_IMPORTED_MODULE_1__["DOCUMENT"]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_2__["PLATFORM_ID"]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_2__["Renderer2"]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_2__["NgZone"]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](QuillService)); };
QuillEditorComponent.ɵcmp = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineComponent"]({ type: QuillEditorComponent, selectors: [["quill-editor"]], features: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵProvidersFeature"]([
            {
                multi: true,
                provide: _angular_forms__WEBPACK_IMPORTED_MODULE_4__["NG_VALUE_ACCESSOR"],
                // eslint-disable-next-line @typescript-eslint/no-use-before-define
                useExisting: Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["forwardRef"])(() => QuillEditorComponent_1)
            },
            {
                multi: true,
                provide: _angular_forms__WEBPACK_IMPORTED_MODULE_4__["NG_VALIDATORS"],
                // eslint-disable-next-line @typescript-eslint/no-use-before-define
                useExisting: Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["forwardRef"])(() => QuillEditorComponent_1)
            }
        ]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵInheritDefinitionFeature"]], ngContentSelectors: _c1, decls: 1, vars: 0, template: function QuillEditorComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵprojectionDef"](_c0);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵprojection"](0);
    } }, encapsulation: 2 });
QuillEditorComponent.ctorParameters = () => [
    { type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["ElementRef"], decorators: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"], args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["ElementRef"],] }] },
    { type: _angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__["DomSanitizer"], decorators: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"], args: [_angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__["DomSanitizer"],] }] },
    { type: undefined, decorators: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"], args: [_angular_common__WEBPACK_IMPORTED_MODULE_1__["DOCUMENT"],] }] },
    { type: undefined, decorators: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"], args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["PLATFORM_ID"],] }] },
    { type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Renderer2"], decorators: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"], args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["Renderer2"],] }] },
    { type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["NgZone"], decorators: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"], args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["NgZone"],] }] },
    { type: QuillService, decorators: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"], args: [QuillService,] }] }
];
QuillEditorComponent = QuillEditorComponent_1 = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([ Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__param"])(0, Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"])(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ElementRef"])),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__param"])(1, Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"])(_angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__["DomSanitizer"])),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__param"])(2, Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"])(_angular_common__WEBPACK_IMPORTED_MODULE_1__["DOCUMENT"])),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__param"])(3, Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"])(_angular_core__WEBPACK_IMPORTED_MODULE_2__["PLATFORM_ID"])),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__param"])(4, Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"])(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Renderer2"])),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__param"])(5, Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"])(_angular_core__WEBPACK_IMPORTED_MODULE_2__["NgZone"])),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__param"])(6, Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"])(QuillService))
], QuillEditorComponent);

let QuillViewHTMLComponent = class QuillViewHTMLComponent {
    constructor(sanitizer, service) {
        this.sanitizer = sanitizer;
        this.service = service;
        this.innerHTML = '';
        this.themeClass = 'ql-snow';
        this.content = '';
    }
    ngOnChanges(changes) {
        if (changes.theme) {
            const theme = changes.theme.currentValue || (this.service.config.theme ? this.service.config.theme : 'snow');
            this.themeClass = `ql-${theme} ngx-quill-view-html`;
        }
        else if (!this.theme) {
            const theme = this.service.config.theme ? this.service.config.theme : 'snow';
            this.themeClass = `ql-${theme} ngx-quill-view-html`;
        }
        if (changes.content) {
            this.innerHTML = this.sanitizer.bypassSecurityTrustHtml(changes.content.currentValue);
        }
    }
};
QuillViewHTMLComponent.ɵfac = function QuillViewHTMLComponent_Factory(t) { return new (t || QuillViewHTMLComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__["DomSanitizer"]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](QuillService)); };
QuillViewHTMLComponent.ɵcmp = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineComponent"]({ type: QuillViewHTMLComponent, selectors: [["quill-view-html"]], inputs: { content: "content", theme: "theme" }, features: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵNgOnChangesFeature"]], decls: 2, vars: 2, consts: [[1, "ql-container", 3, "ngClass"], [1, "ql-editor", 3, "innerHTML"]], template: function QuillViewHTMLComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementStart"](0, "div", 0);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelement"](1, "div", 1);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵelementEnd"]();
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("ngClass", ctx.themeClass);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵadvance"](1);
        _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵproperty"]("innerHTML", ctx.innerHTML, _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵsanitizeHtml"]);
    } }, directives: [_angular_common__WEBPACK_IMPORTED_MODULE_1__["NgClass"]], styles: ["\n.ql-container.ngx-quill-view-html {\n  border: 0;\n}\n"], encapsulation: 2 });
QuillViewHTMLComponent.ctorParameters = () => [
    { type: _angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__["DomSanitizer"], decorators: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"], args: [_angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__["DomSanitizer"],] }] },
    { type: QuillService }
];
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillViewHTMLComponent.prototype, "content", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillViewHTMLComponent.prototype, "theme", void 0);
QuillViewHTMLComponent = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([ Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__param"])(0, Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"])(_angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__["DomSanitizer"]))
], QuillViewHTMLComponent);

let QuillViewComponent = class QuillViewComponent {
    constructor(platformId, renderer, elementRef, zone, service) {
        this.platformId = platformId;
        this.renderer = renderer;
        this.elementRef = elementRef;
        this.zone = zone;
        this.service = service;
        this.strict = true;
        this.customModules = [];
        this.customOptions = [];
        this.preserveWhitespace = false;
        this.valueSetter = (quillEditor, value) => {
            const format = getFormat(this.format, this.service.config.format);
            let content = value;
            if (format === 'html' || format === 'text') {
                content = quillEditor.clipboard.convert(value);
            }
            else if (format === 'json') {
                try {
                    content = JSON.parse(value);
                }
                catch (e) {
                    content = [{ insert: value }];
                }
            }
            quillEditor.setContents(content);
        };
    }
    ngOnChanges(changes) {
        if (!this.quillEditor) {
            return;
        }
        if (changes.content) {
            this.valueSetter(this.quillEditor, changes.content.currentValue);
        }
    }
    ngAfterViewInit() {
        return Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__awaiter"])(this, void 0, void 0, function* () {
            if (Object(_angular_common__WEBPACK_IMPORTED_MODULE_1__["isPlatformServer"])(this.platformId)) {
                return;
            }
            const Quill = yield this.service.getQuill();
            const modules = Object.assign({}, this.modules || this.service.config.modules);
            modules.toolbar = false;
            this.customOptions.forEach((customOption) => {
                const newCustomOption = Quill.import(customOption.import);
                newCustomOption.whitelist = customOption.whitelist;
                Quill.register(newCustomOption, true);
            });
            this.customModules.forEach(({ implementation, path }) => {
                Quill.register(path, implementation);
            });
            let debug = this.debug;
            if (!debug && debug !== false && this.service.config.debug) {
                debug = this.service.config.debug;
            }
            let formats = this.formats;
            if (!formats && formats === undefined) {
                formats = this.service.config.formats ?
                    Object.assign({}, this.service.config.formats) : (this.service.config.formats === null ? null : undefined);
            }
            const theme = this.theme || (this.service.config.theme ? this.service.config.theme : 'snow');
            this.elementRef.nativeElement.insertAdjacentHTML('afterbegin', this.preserveWhitespace ? '<pre quill-view-element></pre>' : '<div quill-view-element></div>');
            this.editorElem = this.elementRef.nativeElement.querySelector('[quill-view-element]');
            this.zone.runOutsideAngular(() => {
                this.quillEditor = new Quill(this.editorElem, {
                    debug: debug,
                    formats: formats,
                    modules,
                    readOnly: true,
                    strict: this.strict,
                    theme
                });
            });
            this.renderer.addClass(this.editorElem, 'ngx-quill-view');
            if (this.content) {
                this.valueSetter(this.quillEditor, this.content);
            }
        });
    }
};
QuillViewComponent.ɵfac = function QuillViewComponent_Factory(t) { return new (t || QuillViewComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_2__["PLATFORM_ID"]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_2__["Renderer2"]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_2__["ElementRef"]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](_angular_core__WEBPACK_IMPORTED_MODULE_2__["NgZone"]), _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdirectiveInject"](QuillService)); };
QuillViewComponent.ɵcmp = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineComponent"]({ type: QuillViewComponent, selectors: [["quill-view"]], inputs: { strict: "strict", customModules: "customModules", customOptions: "customOptions", preserveWhitespace: "preserveWhitespace", format: "format", theme: "theme", modules: "modules", debug: "debug", formats: "formats", content: "content" }, features: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵNgOnChangesFeature"]], decls: 0, vars: 0, template: function QuillViewComponent_Template(rf, ctx) { }, styles: ["\n.ql-container.ngx-quill-view {\n  border: 0;\n}\n"], encapsulation: 2 });
QuillViewComponent.ctorParameters = () => [
    { type: undefined, decorators: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"], args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["PLATFORM_ID"],] }] },
    { type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Renderer2"], decorators: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"], args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["Renderer2"],] }] },
    { type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["ElementRef"], decorators: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"], args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["ElementRef"],] }] },
    { type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["NgZone"], decorators: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"], args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["NgZone"],] }] },
    { type: QuillService, decorators: [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"], args: [QuillService,] }] }
];
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillViewComponent.prototype, "format", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillViewComponent.prototype, "theme", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillViewComponent.prototype, "modules", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillViewComponent.prototype, "debug", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillViewComponent.prototype, "formats", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillViewComponent.prototype, "strict", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillViewComponent.prototype, "content", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillViewComponent.prototype, "customModules", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillViewComponent.prototype, "customOptions", void 0);
Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([
    Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"])()
], QuillViewComponent.prototype, "preserveWhitespace", void 0);
QuillViewComponent = Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__decorate"])([ Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__param"])(0, Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"])(_angular_core__WEBPACK_IMPORTED_MODULE_2__["PLATFORM_ID"])),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__param"])(1, Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"])(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Renderer2"])),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__param"])(2, Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"])(_angular_core__WEBPACK_IMPORTED_MODULE_2__["ElementRef"])),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__param"])(3, Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"])(_angular_core__WEBPACK_IMPORTED_MODULE_2__["NgZone"])),
    Object(tslib__WEBPACK_IMPORTED_MODULE_0__["__param"])(4, Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"])(QuillService))
], QuillViewComponent);

var QuillModule_1;
let QuillModule = QuillModule_1 = class QuillModule {
    static forRoot(config) {
        return {
            ngModule: QuillModule_1,
            providers: [
                {
                    provide: QUILL_CONFIG_TOKEN,
                    useValue: config
                }
            ]
        };
    }
};
QuillModule.ɵmod = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineNgModule"]({ type: QuillModule });
QuillModule.ɵinj = _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵdefineInjector"]({ factory: function QuillModule_Factory(t) { return new (t || QuillModule)(); }, providers: [QuillService], imports: [[_angular_common__WEBPACK_IMPORTED_MODULE_1__["CommonModule"]]] });
/*@__PURE__*/ (function () { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵsetClassMetadata"](QuillService, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Injectable"],
        args: [{
                providedIn: 'root'
            }]
    }], function () { return [{ type: undefined, decorators: [{
                type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"],
                args: [QUILL_CONFIG_TOKEN]
            }] }]; }, null); })();
/*@__PURE__*/ (function () { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵsetClassMetadata"](QuillEditorBase, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Directive"]
    }], function () { return [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["ElementRef"] }, { type: _angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__["DomSanitizer"] }, { type: undefined, decorators: [{
                type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"],
                args: [_angular_common__WEBPACK_IMPORTED_MODULE_1__["DOCUMENT"]]
            }] }, { type: undefined, decorators: [{
                type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"],
                args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["PLATFORM_ID"]]
            }] }, { type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Renderer2"] }, { type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["NgZone"] }, { type: QuillService }]; }, { required: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], customToolbarPosition: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], sanitize: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], styles: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], strict: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], customOptions: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], customModules: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], preserveWhitespace: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], trimOnValidation: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], onEditorCreated: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Output"]
        }], onEditorChanged: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Output"]
        }], onContentChanged: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Output"]
        }], onSelectionChanged: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Output"]
        }], onFocus: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Output"]
        }], onBlur: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Output"]
        }], valueGetter: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], valueSetter: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], format: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], theme: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], modules: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], debug: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], readOnly: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], placeholder: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], maxLength: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], minLength: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], formats: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], scrollingContainer: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], bounds: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], trackChanges: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], classes: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }] }); })();
/*@__PURE__*/ (function () { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵsetClassMetadata"](QuillEditorComponent, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Component"],
        args: [{
                encapsulation: _angular_core__WEBPACK_IMPORTED_MODULE_2__["ViewEncapsulation"].None,
                providers: [
                    {
                        multi: true,
                        provide: _angular_forms__WEBPACK_IMPORTED_MODULE_4__["NG_VALUE_ACCESSOR"],
                        // eslint-disable-next-line @typescript-eslint/no-use-before-define
                        useExisting: Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["forwardRef"])(() => QuillEditorComponent_1)
                    },
                    {
                        multi: true,
                        provide: _angular_forms__WEBPACK_IMPORTED_MODULE_4__["NG_VALIDATORS"],
                        // eslint-disable-next-line @typescript-eslint/no-use-before-define
                        useExisting: Object(_angular_core__WEBPACK_IMPORTED_MODULE_2__["forwardRef"])(() => QuillEditorComponent_1)
                    }
                ],
                selector: 'quill-editor',
                template: `
  <ng-content select="[quill-editor-toolbar]"></ng-content>
`
            }]
    }], function () { return [{ type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["ElementRef"], decorators: [{
                type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"],
                args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["ElementRef"]]
            }] }, { type: _angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__["DomSanitizer"], decorators: [{
                type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"],
                args: [_angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__["DomSanitizer"]]
            }] }, { type: undefined, decorators: [{
                type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"],
                args: [_angular_common__WEBPACK_IMPORTED_MODULE_1__["DOCUMENT"]]
            }] }, { type: undefined, decorators: [{
                type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"],
                args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["PLATFORM_ID"]]
            }] }, { type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Renderer2"], decorators: [{
                type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"],
                args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["Renderer2"]]
            }] }, { type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["NgZone"], decorators: [{
                type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"],
                args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["NgZone"]]
            }] }, { type: QuillService, decorators: [{
                type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"],
                args: [QuillService]
            }] }]; }, null); })();
/*@__PURE__*/ (function () { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵsetClassMetadata"](QuillViewHTMLComponent, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Component"],
        args: [{
                encapsulation: _angular_core__WEBPACK_IMPORTED_MODULE_2__["ViewEncapsulation"].None,
                selector: 'quill-view-html',
                template: `
  <div class="ql-container" [ngClass]="themeClass">
    <div class="ql-editor" [innerHTML]="innerHTML">
    </div>
  </div>
`,
                styles: [`
.ql-container.ngx-quill-view-html {
  border: 0;
}
`]
            }]
    }], function () { return [{ type: _angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__["DomSanitizer"], decorators: [{
                type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"],
                args: [_angular_platform_browser__WEBPACK_IMPORTED_MODULE_3__["DomSanitizer"]]
            }] }, { type: QuillService }]; }, { content: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], theme: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }] }); })();
/*@__PURE__*/ (function () { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵsetClassMetadata"](QuillViewComponent, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Component"],
        args: [{
                encapsulation: _angular_core__WEBPACK_IMPORTED_MODULE_2__["ViewEncapsulation"].None,
                selector: 'quill-view',
                template: `
`,
                styles: [`
.ql-container.ngx-quill-view {
  border: 0;
}
`]
            }]
    }], function () { return [{ type: undefined, decorators: [{
                type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"],
                args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["PLATFORM_ID"]]
            }] }, { type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Renderer2"], decorators: [{
                type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"],
                args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["Renderer2"]]
            }] }, { type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["ElementRef"], decorators: [{
                type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"],
                args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["ElementRef"]]
            }] }, { type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["NgZone"], decorators: [{
                type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"],
                args: [_angular_core__WEBPACK_IMPORTED_MODULE_2__["NgZone"]]
            }] }, { type: QuillService, decorators: [{
                type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Inject"],
                args: [QuillService]
            }] }]; }, { strict: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], customModules: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], customOptions: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], preserveWhitespace: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], format: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], theme: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], modules: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], debug: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], formats: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }], content: [{
            type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["Input"]
        }] }); })();
(function () { (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵɵsetNgModuleScope"](QuillModule, { declarations: function () { return [QuillEditorComponent,
        QuillViewComponent,
        QuillViewHTMLComponent]; }, imports: function () { return [_angular_common__WEBPACK_IMPORTED_MODULE_1__["CommonModule"]]; }, exports: function () { return [QuillEditorComponent,
        QuillViewComponent,
        QuillViewHTMLComponent]; } }); })();
/*@__PURE__*/ (function () { _angular_core__WEBPACK_IMPORTED_MODULE_2__["ɵsetClassMetadata"](QuillModule, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_2__["NgModule"],
        args: [{
                declarations: [
                    QuillEditorComponent,
                    QuillViewComponent,
                    QuillViewHTMLComponent
                ],
                exports: [QuillEditorComponent, QuillViewComponent, QuillViewHTMLComponent],
                imports: [_angular_common__WEBPACK_IMPORTED_MODULE_1__["CommonModule"]],
                providers: [QuillService]
            }]
    }], null, null); })();

/*
 * Public API Surface of ngx-quill
 */

/**
 * Generated bundle index. Do not edit.
 */



//# sourceMappingURL=ngx-quill.js.map

/***/ }),

/***/ "./src/app/models/NewBanner.ts":
/*!*************************************!*\
  !*** ./src/app/models/NewBanner.ts ***!
  \*************************************/
/*! exports provided: NewBanner */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "NewBanner", function() { return NewBanner; });
class NewBanner {
}


/***/ }),

/***/ "./src/app/pages/panel/new-banner/new-banner-routing.module.ts":
/*!*********************************************************************!*\
  !*** ./src/app/pages/panel/new-banner/new-banner-routing.module.ts ***!
  \*********************************************************************/
/*! exports provided: NewBannerRoutingModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "NewBannerRoutingModule", function() { return NewBannerRoutingModule; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/router */ "./node_modules/@angular/router/__ivy_ngcc__/fesm2015/router.js");
/* harmony import */ var _new_banner_component__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./new-banner.component */ "./src/app/pages/panel/new-banner/new-banner.component.ts");
/* harmony import */ var _upsert_upsert_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./upsert/upsert.component */ "./src/app/pages/panel/new-banner/upsert/upsert.component.ts");






const routes = [
    {
        path: '',
        component: _new_banner_component__WEBPACK_IMPORTED_MODULE_2__["NewBannerComponent"]
    },
    {
        path: 'create',
        component: _upsert_upsert_component__WEBPACK_IMPORTED_MODULE_3__["UpsertComponent"]
    },
    {
        path: 'edit/:id',
        component: _upsert_upsert_component__WEBPACK_IMPORTED_MODULE_3__["UpsertComponent"]
    }
];
class NewBannerRoutingModule {
}
NewBannerRoutingModule.ɵmod = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineNgModule"]({ type: NewBannerRoutingModule });
NewBannerRoutingModule.ɵinj = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjector"]({ factory: function NewBannerRoutingModule_Factory(t) { return new (t || NewBannerRoutingModule)(); }, imports: [[_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"].forChild(routes)],
        _angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"]] });
(function () { (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵsetNgModuleScope"](NewBannerRoutingModule, { imports: [_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"]], exports: [_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"]] }); })();
/*@__PURE__*/ (function () { _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](NewBannerRoutingModule, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["NgModule"],
        args: [{
                imports: [_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"].forChild(routes)],
                exports: [_angular_router__WEBPACK_IMPORTED_MODULE_1__["RouterModule"]]
            }]
    }], null, null); })();


/***/ }),

/***/ "./src/app/pages/panel/new-banner/new-banner.component.ts":
/*!****************************************************************!*\
  !*** ./src/app/pages/panel/new-banner/new-banner.component.ts ***!
  \****************************************************************/
/*! exports provided: NewBannerComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "NewBannerComponent", function() { return NewBannerComponent; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
/* harmony import */ var _services_banner_service__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../../services/banner.service */ "./src/app/services/banner.service.ts");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @angular/router */ "./node_modules/@angular/router/__ivy_ngcc__/fesm2015/router.js");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @angular/common */ "./node_modules/@angular/common/__ivy_ngcc__/fesm2015/common.js");





function NewBannerComponent_tr_28_span_9_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "span", 18);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](1, "Activado");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
} }
function NewBannerComponent_tr_28_span_10_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "span", 19);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](1, "Desactivado");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
} }
function NewBannerComponent_tr_28_span_12_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "span", 18);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](1, "Dentro de Horario");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
} }
function NewBannerComponent_tr_28_span_13_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "span", 19);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](1, "Fuera de horario");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
} }
function NewBannerComponent_tr_28_Template(rf, ctx) { if (rf & 1) {
    const _r7 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "tr");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](1, "td", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](3, "td", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](4);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](5, "td", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](6, "span", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](7);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](8, "td", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](9, NewBannerComponent_tr_28_span_9_Template, 2, 0, "span", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](10, NewBannerComponent_tr_28_span_10_Template, 2, 0, "span", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](11, "td", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](12, NewBannerComponent_tr_28_span_12_Template, 2, 0, "span", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](13, NewBannerComponent_tr_28_span_13_Template, 2, 0, "span", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](14, "td", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](15);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](16, "td", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](17);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](18, "td", 13);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](19, "a", 14);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](20, "i", 15);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](21, "a", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵlistener"]("click", function NewBannerComponent_tr_28_Template_a_click_21_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵrestoreView"](_r7); const banner_r1 = ctx.$implicit; const ctx_r6 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵnextContext"](); return ctx_r6.deleteBanner(banner_r1.id); });
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](22, "i", 17);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
} if (rf & 2) {
    const banner_r1 = ctx.$implicit;
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate"](banner_r1.name);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate"](banner_r1.description);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](3);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate"](banner_r1.banner_type);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", banner_r1.is_active);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", !banner_r1.is_active);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", ctx_r0.isBetweenDates(banner_r1.show_at, banner_r1.expiry_at));
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", !ctx_r0.isBetweenDates(banner_r1.show_at, banner_r1.expiry_at));
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate"](banner_r1.show_at.toLocaleString());
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtextInterpolate"](banner_r1.expiry_at.toLocaleString());
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](2);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵpropertyInterpolate1"]("routerLink", "edit/", banner_r1.id, "");
} }
class NewBannerComponent {
    constructor(bannerService) {
        this.bannerService = bannerService;
        this.newBanners = [];
    }
    ngOnInit() {
        this.bannerService.getAllBanners().subscribe(value => {
            this.newBanners = value;
        });
    }
    deleteBanner(id) {
        if (confirm('Eliminar el banner?')) {
            this.bannerService.deleteBanner(id).subscribe(() => {
                this.bannerService.getAllBanners().subscribe(value => {
                    this.newBanners = value;
                });
            });
        }
    }
    isBetweenDates(date1, date2) {
        const dateNow = new Date();
        return (dateNow > date1 && dateNow < date2);
    }
}
NewBannerComponent.ɵfac = function NewBannerComponent_Factory(t) { return new (t || NewBannerComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_services_banner_service__WEBPACK_IMPORTED_MODULE_1__["BannerService"])); };
NewBannerComponent.ɵcmp = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineComponent"]({ type: NewBannerComponent, selectors: [["app-new-banner"]], decls: 29, vars: 1, consts: [[1, "row", "mt-2"], [1, "col-12", "d-flex", "justify-content-start"], [1, "col-12", "d-flex", "justify-content-end"], ["routerLink", "create", 1, "btn", "btn-sm", "btn-primary"], [1, "col-12"], [1, "table", "table-sm"], [1, "thead-dark"], ["scope", "col", 1, "text-center"], [4, "ngFor", "ngForOf"], [1, "text-center"], [1, "badge", "badge-info"], ["class", "badge badge-success", 4, "ngIf"], ["class", "badge badge-secondary", 4, "ngIf"], [1, "d-flex", "justify-content-center"], [3, "routerLink"], [1, "mx-1", "fas", "fa-edit", "text-secondary"], [2, "cursor", "pointer", 3, "click"], [1, "mx-1", "fas", "fa-trash", "text-danger"], [1, "badge", "badge-success"], [1, "badge", "badge-secondary"]], template: function NewBannerComponent_Template(rf, ctx) { if (rf & 1) {
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
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](12, "Nombre");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](13, "th", 7);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](14, "Descripci\u00F3n");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](15, "th", 7);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](16, "Tipo");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](17, "th", 7);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](18, "Activo");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](19, "th", 7);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](20, "Estado");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](21, "th", 7);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](22, "Mostrar desde");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](23, "th", 7);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](24, "Mostrar hasta");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](25, "th", 7);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](26, "Acciones");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](27, "tbody");
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](28, NewBannerComponent_tr_28_Template, 23, 10, "tr", 8);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](28);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngForOf", ctx.newBanners);
    } }, directives: [_angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterLink"], _angular_common__WEBPACK_IMPORTED_MODULE_3__["NgForOf"], _angular_common__WEBPACK_IMPORTED_MODULE_3__["NgIf"], _angular_router__WEBPACK_IMPORTED_MODULE_2__["RouterLinkWithHref"]], styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJzcmMvYXBwL3BhZ2VzL3BhbmVsL25ldy1iYW5uZXIvbmV3LWJhbm5lci5jb21wb25lbnQuc2NzcyJ9 */"] });
/*@__PURE__*/ (function () { _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](NewBannerComponent, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"],
        args: [{
                selector: 'app-new-banner',
                templateUrl: './new-banner.component.html',
                styleUrls: ['./new-banner.component.scss']
            }]
    }], function () { return [{ type: _services_banner_service__WEBPACK_IMPORTED_MODULE_1__["BannerService"] }]; }, null); })();


/***/ }),

/***/ "./src/app/pages/panel/new-banner/new-banner.module.ts":
/*!*************************************************************!*\
  !*** ./src/app/pages/panel/new-banner/new-banner.module.ts ***!
  \*************************************************************/
/*! exports provided: NewBannerModule */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "NewBannerModule", function() { return NewBannerModule; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/common */ "./node_modules/@angular/common/__ivy_ngcc__/fesm2015/common.js");
/* harmony import */ var _new_banner_routing_module__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./new-banner-routing.module */ "./src/app/pages/panel/new-banner/new-banner-routing.module.ts");
/* harmony import */ var _new_banner_component__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./new-banner.component */ "./src/app/pages/panel/new-banner/new-banner.component.ts");
/* harmony import */ var _services_banner_service__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! ../../../services/banner.service */ "./src/app/services/banner.service.ts");
/* harmony import */ var _upsert_upsert_component__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! ./upsert/upsert.component */ "./src/app/pages/panel/new-banner/upsert/upsert.component.ts");
/* harmony import */ var _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @ng-bootstrap/ng-bootstrap */ "./node_modules/@ng-bootstrap/ng-bootstrap/__ivy_ngcc__/fesm2015/ng-bootstrap.js");
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! @angular/forms */ "./node_modules/@angular/forms/__ivy_ngcc__/fesm2015/forms.js");
/* harmony import */ var ngx_quill__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! ngx-quill */ "./node_modules/ngx-quill/__ivy_ngcc__/fesm2015/ngx-quill.js");











class NewBannerModule {
}
NewBannerModule.ɵmod = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineNgModule"]({ type: NewBannerModule });
NewBannerModule.ɵinj = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjector"]({ factory: function NewBannerModule_Factory(t) { return new (t || NewBannerModule)(); }, providers: [_services_banner_service__WEBPACK_IMPORTED_MODULE_4__["BannerService"]], imports: [[
            _angular_common__WEBPACK_IMPORTED_MODULE_1__["CommonModule"],
            _new_banner_routing_module__WEBPACK_IMPORTED_MODULE_2__["NewBannerRoutingModule"],
            _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_6__["NgbDatepickerModule"],
            _angular_forms__WEBPACK_IMPORTED_MODULE_7__["ReactiveFormsModule"],
            ngx_quill__WEBPACK_IMPORTED_MODULE_8__["QuillModule"].forRoot({
                modules: {
                    toolbar: [
                        // ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
                        [/*'blockquote',*/ 'code-block'],
                        // [{ 'header': 1 }, { 'header': 2 }],               // custom button values
                        // [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                        // [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
                        // [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
                        // [{ 'direction': 'rtl' }],                         // text direction
                        // [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
                        // [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                        // [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
                        // [{ 'font': [] }],
                        [{ 'align': [] }],
                        // ['clean'],                                         // remove formatting button
                        ['link', 'image']
                    ]
                }
            })
        ]] });
(function () { (typeof ngJitMode === "undefined" || ngJitMode) && _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵsetNgModuleScope"](NewBannerModule, { declarations: [_new_banner_component__WEBPACK_IMPORTED_MODULE_3__["NewBannerComponent"], _upsert_upsert_component__WEBPACK_IMPORTED_MODULE_5__["UpsertComponent"]], imports: [_angular_common__WEBPACK_IMPORTED_MODULE_1__["CommonModule"],
        _new_banner_routing_module__WEBPACK_IMPORTED_MODULE_2__["NewBannerRoutingModule"],
        _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_6__["NgbDatepickerModule"],
        _angular_forms__WEBPACK_IMPORTED_MODULE_7__["ReactiveFormsModule"], ngx_quill__WEBPACK_IMPORTED_MODULE_8__["QuillModule"]], exports: [_new_banner_component__WEBPACK_IMPORTED_MODULE_3__["NewBannerComponent"]] }); })();
/*@__PURE__*/ (function () { _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](NewBannerModule, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["NgModule"],
        args: [{
                declarations: [_new_banner_component__WEBPACK_IMPORTED_MODULE_3__["NewBannerComponent"], _upsert_upsert_component__WEBPACK_IMPORTED_MODULE_5__["UpsertComponent"]],
                imports: [
                    _angular_common__WEBPACK_IMPORTED_MODULE_1__["CommonModule"],
                    _new_banner_routing_module__WEBPACK_IMPORTED_MODULE_2__["NewBannerRoutingModule"],
                    _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_6__["NgbDatepickerModule"],
                    _angular_forms__WEBPACK_IMPORTED_MODULE_7__["ReactiveFormsModule"],
                    ngx_quill__WEBPACK_IMPORTED_MODULE_8__["QuillModule"].forRoot({
                        modules: {
                            toolbar: [
                                // ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
                                [/*'blockquote',*/ 'code-block'],
                                // [{ 'header': 1 }, { 'header': 2 }],               // custom button values
                                // [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                                // [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
                                // [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
                                // [{ 'direction': 'rtl' }],                         // text direction
                                // [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
                                // [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                                // [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
                                // [{ 'font': [] }],
                                [{ 'align': [] }],
                                // ['clean'],                                         // remove formatting button
                                ['link', 'image']
                            ]
                        }
                    })
                ],
                exports: [_new_banner_component__WEBPACK_IMPORTED_MODULE_3__["NewBannerComponent"]],
                providers: [_services_banner_service__WEBPACK_IMPORTED_MODULE_4__["BannerService"]]
            }]
    }], null, null); })();


/***/ }),

/***/ "./src/app/pages/panel/new-banner/upsert/upsert.component.ts":
/*!*******************************************************************!*\
  !*** ./src/app/pages/panel/new-banner/upsert/upsert.component.ts ***!
  \*******************************************************************/
/*! exports provided: UpsertComponent */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "UpsertComponent", function() { return UpsertComponent; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
/* harmony import */ var _angular_forms__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @angular/forms */ "./node_modules/@angular/forms/__ivy_ngcc__/fesm2015/forms.js");
/* harmony import */ var _models_NewBanner__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../models/NewBanner */ "./src/app/models/NewBanner.ts");
/* harmony import */ var _services_banner_service__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ../../../../services/banner.service */ "./src/app/services/banner.service.ts");
/* harmony import */ var _angular_router__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/router */ "./node_modules/@angular/router/__ivy_ngcc__/fesm2015/router.js");
/* harmony import */ var _angular_common__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @angular/common */ "./node_modules/@angular/common/__ivy_ngcc__/fesm2015/common.js");
/* harmony import */ var _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @ng-bootstrap/ng-bootstrap */ "./node_modules/@ng-bootstrap/ng-bootstrap/__ivy_ngcc__/fesm2015/ng-bootstrap.js");
/* harmony import */ var ngx_quill__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! ngx-quill */ "./node_modules/ngx-quill/__ivy_ngcc__/fesm2015/ngx-quill.js");










function UpsertComponent_div_1_img_47_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](0, "img", 43);
} }
function UpsertComponent_div_1_img_48_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](0, "img", 44);
} }
function UpsertComponent_div_1_img_49_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](0, "img", 45);
} }
function UpsertComponent_div_1_img_50_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](0, "img", 46);
} }
function UpsertComponent_div_1_img_51_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](0, "img", 47);
} }
function UpsertComponent_div_1_img_52_Template(rf, ctx) { if (rf & 1) {
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](0, "img", 48);
} }
const _c0 = function () { return { height: "500px" }; };
function UpsertComponent_div_1_Template(rf, ctx) { if (rf & 1) {
    const _r8 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵgetCurrentView"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "div", 2);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵlistener"]("submit", function UpsertComponent_div_1_Template_div_submit_0_listener() { _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵrestoreView"](_r8); const ctx_r7 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵnextContext"](); return ctx_r7.onSubmit(); });
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](1, "form", 3);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](2, "div", 0);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](3, "div", 4);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](4, "h3");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](5, "Banner publicitario");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](6, "div", 5);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](7, "div", 0);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](8, "div", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](9, "label", 7);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](10, "Nombre");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](11, "input", 8);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](12, "div", 6);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](13, "div", 9);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](14, "input", 10);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](15, "label", 11);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](16, "Activo");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](17, "div", 12);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](18, "label", 13);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](19, "Descripci\u00F3n");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](20, "textarea", 14);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](21, "div", 15);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](22, "div", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](23, "input", 17);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](24, "label", 18);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](25, "Interstitial");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](26, "div", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](27, "input", 19);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](28, "label", 20);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](29, "Push Down");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](30, "div", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](31, "input", 21);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](32, "label", 22);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](33, "Topboard");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](34, "div", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](35, "input", 23);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](36, "label", 24);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](37, "Layer");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](38, "div", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](39, "input", 25);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](40, "label", 26);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](41, "Push Down Mobile");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](42, "div", 16);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](43, "input", 27);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](44, "label", 28);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](45, "Banner Mobile");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](46, "div", 29);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](47, UpsertComponent_div_1_img_47_Template, 1, 0, "img", 30);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](48, UpsertComponent_div_1_img_48_Template, 1, 0, "img", 31);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](49, UpsertComponent_div_1_img_49_Template, 1, 0, "img", 32);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](50, UpsertComponent_div_1_img_50_Template, 1, 0, "img", 33);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](51, UpsertComponent_div_1_img_51_Template, 1, 0, "img", 34);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](52, UpsertComponent_div_1_img_52_Template, 1, 0, "img", 35);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](53, "div", 36);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](54, "div", 0);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](55, "div", 37);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](56, "label");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](57, "Mostrar desde");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](58, "div");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](59, "ngb-datepicker", 38);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](60, "div", 37);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](61, "label");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](62, "Mostrar hasta");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](63, "div");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](64, "ngb-datepicker", 39);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](65, "div", 36);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](66, "label");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](67, "Contenido");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelement"](68, "quill-editor", 40);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](69, "div", 41);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](70, "button", 42);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtext"](71, "Guardar");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
} if (rf & 2) {
    const ctx_r0 = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵnextContext"]();
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("formGroup", ctx_r0.formGroupUpsert);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](46);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", ctx_r0.formGroupUpsert.get("type").value === "interstitial");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", ctx_r0.formGroupUpsert.get("type").value === "push_down");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", ctx_r0.formGroupUpsert.get("type").value === "top_board");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", ctx_r0.formGroupUpsert.get("type").value === "layer");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", ctx_r0.formGroupUpsert.get("type").value === "push_down_mobile");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](1);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", ctx_r0.formGroupUpsert.get("type").value === "banner_mobile");
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](16);
    _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵstyleMap"](_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵpureFunction0"](9, _c0));
} }
class UpsertComponent {
    constructor(bannerService, router, activatedRoute) {
        this.bannerService = bannerService;
        this.router = router;
        this.activatedRoute = activatedRoute;
        this.updateId = null;
    }
    ngOnInit() {
        const updateId = this.activatedRoute.snapshot.params['id'];
        if (updateId) {
            this.updateId = updateId;
            this.bannerService.getBannerById(updateId).subscribe(value => {
                const dateShowAt = new Date(value.show_at);
                const dateExpiryAt = new Date(value.expiry_at);
                console.log(dateShowAt);
                console.log(dateExpiryAt);
                const showAt = {
                    year: dateShowAt.getFullYear(),
                    month: dateShowAt.getMonth() + 1,
                    day: dateShowAt.getDate(),
                };
                const expiryAt = {
                    year: dateExpiryAt.getFullYear(),
                    month: dateExpiryAt.getMonth() + 1,
                    day: dateExpiryAt.getDate(),
                };
                this.formGroupUpsert = new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormGroup"]({
                    name: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"](value.name, [_angular_forms__WEBPACK_IMPORTED_MODULE_1__["Validators"].required]),
                    description: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"](value.description),
                    type: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"](value.banner_type, [_angular_forms__WEBPACK_IMPORTED_MODULE_1__["Validators"].required]),
                    content: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"](value.content, [_angular_forms__WEBPACK_IMPORTED_MODULE_1__["Validators"].required]),
                    isActive: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"](value.is_active, [_angular_forms__WEBPACK_IMPORTED_MODULE_1__["Validators"].required]),
                    showAt: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"](showAt, [_angular_forms__WEBPACK_IMPORTED_MODULE_1__["Validators"].required]),
                    expiryAt: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"](expiryAt, [_angular_forms__WEBPACK_IMPORTED_MODULE_1__["Validators"].required]),
                });
            });
        }
        else {
            this.formGroupUpsert = new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormGroup"]({
                name: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"]('', [_angular_forms__WEBPACK_IMPORTED_MODULE_1__["Validators"].required]),
                description: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"](''),
                type: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"]('interstitial', [_angular_forms__WEBPACK_IMPORTED_MODULE_1__["Validators"].required]),
                content: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"]('', [_angular_forms__WEBPACK_IMPORTED_MODULE_1__["Validators"].required]),
                isActive: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"](false, [_angular_forms__WEBPACK_IMPORTED_MODULE_1__["Validators"].required]),
                showAt: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"](false, [_angular_forms__WEBPACK_IMPORTED_MODULE_1__["Validators"].required]),
                expiryAt: new _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControl"](false, [_angular_forms__WEBPACK_IMPORTED_MODULE_1__["Validators"].required]),
            });
        }
    }
    onSubmit() {
        for (const i in this.formGroupUpsert.controls) {
            this.formGroupUpsert.controls[i].markAsDirty();
            this.formGroupUpsert.controls[i].updateValueAndValidity();
            console.log(this.formGroupUpsert.controls[i].value);
        }
        if (this.formGroupUpsert.invalid) {
            return;
        }
        const newBanner = new _models_NewBanner__WEBPACK_IMPORTED_MODULE_2__["NewBanner"]();
        newBanner.name = this.formGroupUpsert.controls['name'].value;
        newBanner.description = this.formGroupUpsert.controls['description'].value;
        newBanner.banner_type = this.formGroupUpsert.controls['type'].value;
        newBanner.content = this.formGroupUpsert.controls['content'].value;
        newBanner.is_active = this.formGroupUpsert.controls['isActive'].value;
        const show = this.formGroupUpsert.controls['showAt'].value;
        const expiry = this.formGroupUpsert.controls['expiryAt'].value;
        const dateShow = new Date(show.year, show.month - 1, show.day, 0, 0, 0);
        const dateExpiry = new Date(expiry.year, expiry.month - 1, expiry.day, 23, 59, 59);
        newBanner.show_at = dateShow.toLocaleString();
        newBanner.expiry_at = dateExpiry.toLocaleString();
        if (this.updateId) {
            this.bannerService.updateBanner(this.updateId, newBanner).subscribe(value => {
                this.router.navigate(['/panel/new-banner']);
            });
        }
        else {
            this.bannerService.createBanner(newBanner).subscribe(value => {
                this.router.navigate(['/panel/new-banner']);
            });
        }
    }
}
UpsertComponent.ɵfac = function UpsertComponent_Factory(t) { return new (t || UpsertComponent)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_services_banner_service__WEBPACK_IMPORTED_MODULE_3__["BannerService"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"]), _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdirectiveInject"](_angular_router__WEBPACK_IMPORTED_MODULE_4__["ActivatedRoute"])); };
UpsertComponent.ɵcmp = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineComponent"]({ type: UpsertComponent, selectors: [["app-upsert"]], decls: 2, vars: 1, consts: [[1, "row"], ["class", "col-12 card", 3, "submit", 4, "ngIf"], [1, "col-12", "card", 3, "submit"], [3, "formGroup"], [1, "col-12"], [1, "mt-4", "col-12", "col-md-6"], [1, "form-group", "col-12"], ["for", "inputName"], ["formControlName", "name", "type", "text", "id", "inputName", "placeholder", "Nombre", 1, "form-control", "form-control-sm"], [1, "custom-control", "custom-checkbox"], ["formControlName", "isActive", "type", "checkbox", "id", "checkboxIsActive", 1, "custom-control-input"], ["for", "checkboxIsActive", 1, "custom-control-label"], [1, "mt-4", "form-group", "col-12", "col-md-6"], ["for", "inputDescription"], ["formControlName", "description", "id", "inputDescription", "rows", "3", 1, "form-control"], [1, "mt-4", "col-12", "col-md-6", "form-group"], [1, "custom-control", "custom-radio", "custom-control-inline"], ["type", "radio", "id", "radioTypeInterstitial", "formControlName", "type", "value", "interstitial", 1, "custom-control-input"], ["for", "radioTypeInterstitial", 1, "custom-control-label"], ["type", "radio", "id", "radioTypePusDown", "formControlName", "type", "value", "push_down", 1, "custom-control-input"], ["for", "radioTypePusDown", 1, "custom-control-label"], ["type", "radio", "id", "radioTypeTopBoard", "formControlName", "type", "value", "top_board", 1, "custom-control-input"], ["for", "radioTypeTopBoard", 1, "custom-control-label"], ["type", "radio", "id", "radioTypeLayer", "formControlName", "type", "value", "layer", 1, "custom-control-input"], ["for", "radioTypeLayer", 1, "custom-control-label"], ["type", "radio", "id", "radioPushDownMobile", "formControlName", "type", "value", "push_down_mobile", 1, "custom-control-input"], ["for", "radioPushDownMobile", 1, "custom-control-label"], ["type", "radio", "id", "radioBannerMobile", "formControlName", "type", "value", "banner_mobile", 1, "custom-control-input"], ["for", "radioBannerMobile", 1, "custom-control-label"], [1, "mt-4", "col-12", "col-md-6", "d-flex", "justify-content-center"], ["class", "max-height-image-type", "src", "https://verticeads.com/content/webdeveloper/images/ico_interstitial.png?v=1589295029", "alt", "Example", 4, "ngIf"], ["class", "max-height-image-type", "src", "https://verticeads.com/content/webdeveloper/images/ico_pushdown.png?v=1589295029", "alt", "Example", 4, "ngIf"], ["class", "max-height-image-type", "src", "https://verticeads.com/content/webdeveloper/images/ico_topboard.png?v=1589295029", "alt", "Example", 4, "ngIf"], ["class", "max-height-image-type", "src", "https://verticeads.com/content/webdeveloper/images/ico_layer.png?v=1589295029", "alt", "Example", 4, "ngIf"], ["class", "max-height-image-type", "src", "https://verticeads.com/content/webdeveloper/images/mobile2.png?v=1589295029", "alt", "Example", 4, "ngIf"], ["class", "max-height-image-type", "src", "https://verticeads.com/content/webdeveloper/images/mobile1.png?v=1589295029", "alt", "Example", 4, "ngIf"], [1, "mt-4", "col-12"], [1, "col-12", "col-md-6", "d-flex", "flex-column"], ["formControlName", "showAt"], ["formControlName", "expiryAt"], ["format", "json", "formControlName", "content"], [1, "col-12", "d-flex", "justify-content-end", 2, "margin-top", "150px"], ["type", "submit", 1, "btn", "btn-sm", "btn-primary", "my-2"], ["src", "https://verticeads.com/content/webdeveloper/images/ico_interstitial.png?v=1589295029", "alt", "Example", 1, "max-height-image-type"], ["src", "https://verticeads.com/content/webdeveloper/images/ico_pushdown.png?v=1589295029", "alt", "Example", 1, "max-height-image-type"], ["src", "https://verticeads.com/content/webdeveloper/images/ico_topboard.png?v=1589295029", "alt", "Example", 1, "max-height-image-type"], ["src", "https://verticeads.com/content/webdeveloper/images/ico_layer.png?v=1589295029", "alt", "Example", 1, "max-height-image-type"], ["src", "https://verticeads.com/content/webdeveloper/images/mobile2.png?v=1589295029", "alt", "Example", 1, "max-height-image-type"], ["src", "https://verticeads.com/content/webdeveloper/images/mobile1.png?v=1589295029", "alt", "Example", 1, "max-height-image-type"]], template: function UpsertComponent_Template(rf, ctx) { if (rf & 1) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementStart"](0, "div", 0);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵtemplate"](1, UpsertComponent_div_1_Template, 72, 10, "div", 1);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵelementEnd"]();
    } if (rf & 2) {
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵadvance"](1);
        _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵproperty"]("ngIf", ctx.formGroupUpsert);
    } }, directives: [_angular_common__WEBPACK_IMPORTED_MODULE_5__["NgIf"], _angular_forms__WEBPACK_IMPORTED_MODULE_1__["ɵangular_packages_forms_forms_y"], _angular_forms__WEBPACK_IMPORTED_MODULE_1__["NgControlStatusGroup"], _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormGroupDirective"], _angular_forms__WEBPACK_IMPORTED_MODULE_1__["DefaultValueAccessor"], _angular_forms__WEBPACK_IMPORTED_MODULE_1__["NgControlStatus"], _angular_forms__WEBPACK_IMPORTED_MODULE_1__["FormControlName"], _angular_forms__WEBPACK_IMPORTED_MODULE_1__["CheckboxControlValueAccessor"], _angular_forms__WEBPACK_IMPORTED_MODULE_1__["RadioControlValueAccessor"], _ng_bootstrap_ng_bootstrap__WEBPACK_IMPORTED_MODULE_6__["NgbDatepicker"], ngx_quill__WEBPACK_IMPORTED_MODULE_7__["QuillEditorComponent"]], styles: [".max-height-image-type[_ngcontent-%COMP%] {\n  height: 300px;\n}\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9ob21lL2VkdWFyZG8vZ2xvYmFsLW1lZGlhL25nLWNsaWVudC9zcmMvYXBwL3BhZ2VzL3BhbmVsL25ldy1iYW5uZXIvdXBzZXJ0L3Vwc2VydC5jb21wb25lbnQuc2NzcyIsInNyYy9hcHAvcGFnZXMvcGFuZWwvbmV3LWJhbm5lci91cHNlcnQvdXBzZXJ0LmNvbXBvbmVudC5zY3NzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0VBQ0UsYUFBQTtBQ0NGIiwiZmlsZSI6InNyYy9hcHAvcGFnZXMvcGFuZWwvbmV3LWJhbm5lci91cHNlcnQvdXBzZXJ0LmNvbXBvbmVudC5zY3NzIiwic291cmNlc0NvbnRlbnQiOlsiLm1heC1oZWlnaHQtaW1hZ2UtdHlwZSB7XG4gIGhlaWdodDogMzAwcHg7XG59XG4iLCIubWF4LWhlaWdodC1pbWFnZS10eXBlIHtcbiAgaGVpZ2h0OiAzMDBweDtcbn0iXX0= */"] });
/*@__PURE__*/ (function () { _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](UpsertComponent, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Component"],
        args: [{
                selector: 'app-upsert',
                templateUrl: './upsert.component.html',
                styleUrls: ['./upsert.component.scss']
            }]
    }], function () { return [{ type: _services_banner_service__WEBPACK_IMPORTED_MODULE_3__["BannerService"] }, { type: _angular_router__WEBPACK_IMPORTED_MODULE_4__["Router"] }, { type: _angular_router__WEBPACK_IMPORTED_MODULE_4__["ActivatedRoute"] }]; }, null); })();


/***/ }),

/***/ "./src/app/services/banner.service.ts":
/*!********************************************!*\
  !*** ./src/app/services/banner.service.ts ***!
  \********************************************/
/*! exports provided: BannerService */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "BannerService", function() { return BannerService; });
/* harmony import */ var _angular_core__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @angular/core */ "./node_modules/@angular/core/__ivy_ngcc__/fesm2015/core.js");
/* harmony import */ var _base_endpoint_service__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./base-endpoint.service */ "./src/app/services/base-endpoint.service.ts");
/* harmony import */ var rxjs_operators__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! rxjs/operators */ "./node_modules/rxjs/_esm2015/operators/index.js");
/* harmony import */ var moment__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! moment */ "./node_modules/moment/moment.js");
/* harmony import */ var moment__WEBPACK_IMPORTED_MODULE_3___default = /*#__PURE__*/__webpack_require__.n(moment__WEBPACK_IMPORTED_MODULE_3__);
/* harmony import */ var _angular_common_http__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @angular/common/http */ "./node_modules/@angular/common/__ivy_ngcc__/fesm2015/http.js");






class BannerService extends _base_endpoint_service__WEBPACK_IMPORTED_MODULE_1__["BaseEndpointService"] {
    constructor(httpClient) {
        super(httpClient);
    }
    getAllBanners() {
        const url = `${this.apiUrl}/new_banner`;
        return this.httpClient.get(url, this.getHeaders()).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["catchError"])(err => this.handleError(err)), Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["map"])(value => {
            for (let i = 0; i < value.length; i++) {
                value[i].show_at = moment__WEBPACK_IMPORTED_MODULE_3__(value[i].show_at).toDate();
                value[i].expiry_at = moment__WEBPACK_IMPORTED_MODULE_3__(value[i].expiry_at).toDate();
                value[i].created_at = moment__WEBPACK_IMPORTED_MODULE_3__(value[i].created_at).toDate();
                value[i].updated_at = moment__WEBPACK_IMPORTED_MODULE_3__(value[i].updated_at).toDate();
            }
            return value;
        }));
    }
    getBannersForNow() {
        const url = `${this.apiUrl}/new_banner/now`;
        return this.httpClient.get(url, this.getHeaders()).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["catchError"])(err => this.handleError(err)), Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["map"])(value => {
            for (let i = 0; i < value.length; i++) {
                value[i].show_at = moment__WEBPACK_IMPORTED_MODULE_3__(value[i].show_at).toDate();
                value[i].expiry_at = moment__WEBPACK_IMPORTED_MODULE_3__(value[i].expiry_at).toDate();
                value[i].created_at = moment__WEBPACK_IMPORTED_MODULE_3__(value[i].created_at).toDate();
                value[i].updated_at = moment__WEBPACK_IMPORTED_MODULE_3__(value[i].updated_at).toDate();
            }
            return value;
        }));
    }
    getBannerById(id) {
        const url = `${this.apiUrl}/new_banner/${id}`;
        return this.httpClient.get(url, this.getHeaders()).pipe(Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["catchError"])(err => this.handleError(err)), Object(rxjs_operators__WEBPACK_IMPORTED_MODULE_2__["map"])(value => {
            if (value) {
                value.show_at = moment__WEBPACK_IMPORTED_MODULE_3__(value.show_at).toDate();
                value.expiry_at = moment__WEBPACK_IMPORTED_MODULE_3__(value.expiry_at).toDate();
                value.created_at = moment__WEBPACK_IMPORTED_MODULE_3__(value.created_at).toDate();
                value.updated_at = moment__WEBPACK_IMPORTED_MODULE_3__(value.updated_at).toDate();
            }
            return value;
        }));
    }
    createBanner(newBanner) {
        const url = `${this.apiUrl}/new_banner`;
        return this.httpClient.post(url, newBanner, this.getHeaders());
    }
    updateBanner(id, newBanner) {
        const url = `${this.apiUrl}/new_banner/${id}`;
        return this.httpClient.patch(url, newBanner, this.getHeaders());
    }
    deleteBanner(id) {
        const url = `${this.apiUrl}/new_banner/${id}`;
        return this.httpClient.delete(url, this.getHeaders());
    }
}
BannerService.ɵfac = function BannerService_Factory(t) { return new (t || BannerService)(_angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵinject"](_angular_common_http__WEBPACK_IMPORTED_MODULE_4__["HttpClient"])); };
BannerService.ɵprov = _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵɵdefineInjectable"]({ token: BannerService, factory: BannerService.ɵfac });
/*@__PURE__*/ (function () { _angular_core__WEBPACK_IMPORTED_MODULE_0__["ɵsetClassMetadata"](BannerService, [{
        type: _angular_core__WEBPACK_IMPORTED_MODULE_0__["Injectable"]
    }], function () { return [{ type: _angular_common_http__WEBPACK_IMPORTED_MODULE_4__["HttpClient"] }]; }, null); })();


/***/ })

}]);
//# sourceMappingURL=new-banner-new-banner-module-es2015.js.map