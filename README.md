mock-jquery-ajax
================

case 中用法:

mockAjax = require 'lib/mock-jquery-ajax'

respData = {}

Mock = mockAjax(respData)

before ()->
  Mock.mock()

after ()->
 Mock.unmock()
 
 
 
 
