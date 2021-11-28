(function(global, factory) {
    if (typeof define === 'function' && define.amd) {
        define('preact', ['exports', 'module'], factory);
    } else if (typeof exports !== 'undefined' && typeof module !== 'undefined') {
        factory(exports, module);
    } else {
        var mod = {
            exports: {}
        };
        factory(mod.exports, mod);
        global.preact = mod.exports;
    }
})(this, function(exports, module) {
    module.exports = {
        createClass: function() {},
        createElement: function() {}
    };
});
