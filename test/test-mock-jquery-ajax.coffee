MockAjax  = require './lib/mock-jquery-ajax'
expect    = require 'expect.js'

describe 'mock-jquery-ajax', () ->
  
  it 'sample request', () ->
    respData = {
      a : '123'
      b : 'abc'
    }
    mock = MockAjax(respData)

    mock.ajax({
      url : '/test/abc/test.json'
      method : 'GET'
      dataType: 'json'
      jsonp: 'callback'
      success: (data) ->
        expect(data).to.eql(respData)
      complete: (data, status) ->
        expect(status).to.eql('success')        
    })
    mock.unmock()

  it 'error', () ->
    respData = null
    
    mock = MockAjax(respData)

    mock.ajax({
      url : '/test/abc/test.json',
      method : 'GET',
      dataType: 'json',
      error: (data, code, msg) ->
        expect(data).to.be(null)
        expect(code).to.be('error')
        expect(msg).to.be('Not Found')
      complete: (data, status) ->
        expect(status).to.eql('error')        
    })
    mock.unmock() 
