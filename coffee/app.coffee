requirejs.config
  paths:
    jquery: ["//cdnjs.cloudflare.com/ajax/libs/jquery/1.10.2/jquery.min", "vendor/jquery"]
    underscore: ["//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.5.1/underscore-min", "vendor/underscore"]
    mustache: ["//cdnjs.cloudflare.com/ajax/libs/mustache.js/0.7.2/mustache.min", "vendor/mustache"]
    tictail: ["//sdk.ttcdn.co/tt"]
    uikit: ["//sdk.ttcdn.co/tt-uikit-0.11.0.min"]
    text: ["vendor/text"]
  shim:
    underscore:
      exports: "_"
    jquery:
      exports: ["jQuery"]
    tictail:
      deps: ["jquery"]
      exports: "TT"
    uikit:
      deps: ["jquery","tictail"]

define (require) ->
  system  = require("tictail").native
  api     = require("tictail").api
  store   = null

  system.init().done () ->
    api.get('v1/me').done start


  start = (data) ->
    store = data
    getProducts()

  getProducts = () ->
    api.get("v1/stores/#{store.id}/products").done (data) ->
      console.log arguments
      
