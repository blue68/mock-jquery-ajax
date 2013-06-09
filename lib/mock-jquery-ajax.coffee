$        = require('jquery')
os       = require 'options-stream'
realAjax = $.ajax

class MockAjax 
  constructor :(data) ->
    @respData = data || null

  ajax : (opts) =>
    @opts = os opts, {
      type : 'GET'
      dataType : 'json'
      async : true
    }

    if @opts.data
      @opts.url += "?#{$.param(@opts.data)}"
    
    status = 'success'
    status = 'error' unless @respData
    if @respData
      if typeof @opts.success is 'function'
        @opts.success @respData
    else
      if typeof @opts.error is 'function'
        @opts.error null, 'error', 'Not Found'

    if typeof @opts.complete is 'function'
      return @opts.complete {}, status
    else 
      return undefined
  mock : () ->
    $.ajax = @ajax

  unmock : () ->
    require('jquery').ajax = realAjax

module.exports = (data) ->
  return new MockAjax(data)  
