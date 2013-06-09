(function() {
  var $, MockAjax, os, realAjax,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  $ = require('jquery');

  os = require('options-stream');

  realAjax = $.ajax;

  MockAjax = (function() {
    function MockAjax(data) {
      this.ajax = __bind(this.ajax, this);      this.respData = data || null;
    }

    MockAjax.prototype.ajax = function(opts) {
      var status;

      this.opts = os(opts, {
        type: 'GET',
        dataType: 'json',
        async: true
      });
      if (this.opts.data) {
        this.opts.url += "?" + ($.param(this.opts.data));
      }
      status = 'success';
      if (!this.respData) {
        status = 'error';
      }
      if (this.respData) {
        if (typeof this.opts.success === 'function') {
          this.opts.success(this.respData);
        }
      } else {
        if (typeof this.opts.error === 'function') {
          this.opts.error(null, 'error', 'Not Found');
        }
      }
      if (typeof this.opts.complete === 'function') {
        return this.opts.complete({}, status);
      } else {
        return void 0;
      }
    };

    MockAjax.prototype.mock = function() {
      return $.ajax = this.ajax;
    };

    MockAjax.prototype.unmock = function() {
      return require('jquery').ajax = realAjax;
    };

    return MockAjax;

  })();

  module.exports = function(data) {
    return new MockAjax(data);
  };

}).call(this);
