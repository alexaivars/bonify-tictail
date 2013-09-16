define (require) ->
  _ = require("underscore")
  $ = require("jquery")


  listProducts = (products) ->

    image_wrapper = document.getElementById( 'carousel__images_wrapper' ).cloneNode()

    _.each products, (product) ->
      # debugger
      image           = product.images[0]
      image.name      = image.sizes['30'].split('30/')[1]
      image.baseUrl   = image.sizes['30'].split('30/')[0]

      item            = document.createElement('label')
      item.for        = image.id
      item.classList.add('carousel__item')
      text            = document.createElement('span')
      text.innerHTML  = product.title
      text.classList.add('carousel__label_text')
      chb             = document.createElement('input')
      chb.type        = 'checkbox'
      chb.name        = image.baseUrl + '___' + image.name
      chb.setAttribute('id', image.id)
      chb.classList.add('carousel__input')
      img             = document.createElement('img')
      img.src         = image.sizes['300']
      img.classList.add('carousel__image')
      mark            = document.createElement('span')
      # debugger
      mark.setAttribute('data-icon', '&#xe000;')
      mark.setAttribute('aria-hidden', 'true')
      mark.classList.add('carousel__selected_icon')
      item.appendChild(chb)
      item.appendChild(img)
      item.appendChild(text)
      item.appendChild(mark)
      image_wrapper.appendChild(item)
      document.getElementById('carousel_form')
        .replaceChild(image_wrapper, document.getElementById( 'carousel__images_wrapper' ))
    listProducts.listener()
    @

  listProducts.saveSelection = (imageList) ->
    # debugger
    listProducts.succe()
    # $.ajax
    #   url: 'myAwesomeServer'
    #   success: (resp) ->
    #     # Do stuff with responce


  listProducts.succe = ->
    if $('.success').length < 1
      $('#carousel_form').after($('<p class="success" />').text('Carousel is updated'))
    setTimeout ->
      # debugger
      $('.success').addClass('visible')
      setTimeout ->
        # debugger
        $('.success').removeClass('visible')
        setTimeout ->
          # debugger
          $('.success').remove()
          @
        ,900
        @
      ,2500
      @
    ,100


  listProducts.fail = ->
    if $('.fail').length < 1
      $('#carousel_form').after($('<p class="fail" />').text('Update failed, try again.'))
    setTimeout ->
      # debugger
      $('.fail').addClass('visible')
      setTimeout ->
        # debugger
        $('.fail').removeClass('visible')
        setTimeout ->
          # debugger
          $('.fail').remove()
          @
        ,900
        @
      ,3500
      @
    ,100


  listProducts.listener = ->
    $('body').on 'change', '.carousel__input', ->
      if $(@).is ':checked'
        $(@).parent().addClass 'selected'
      else
        $(@).parent().removeClass 'selected'

    $('#carousel_form').on 'submit', (e) ->
      e.preventDefault()
      images = _.map $(@).serializeArray(), (obj) ->
        { name: obj.name.split('___')[1], baseUrl: obj.name.split('___')[0] }
      listProducts.saveSelection(images)

  listProducts
# "https://dtvep25tfu0n1.cloudfront.net/media/resize/product/2000/67244-87d25713d51944d1b61e8bdd94cf5d23.jpeg"