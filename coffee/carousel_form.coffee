define (require) ->
  _ = require("underscore")
  $ = require("jquery")


  listProducts = (products) ->

    image_wrapper = document.getElementById( 'carousel__images_wrapper' ).cloneNode()

    _.each products, (product) ->
      # debugger
      item            = document.createElement('label')
      item.for        = product.title
      item.classList.add('carousel__item')
      text            = document.createElement('span')
      text.innerHTML  = product.title
      text.classList.add('carousel__label_text')
      chb             = document.createElement('input')
      chb.type        = 'checkbox'
      chb.name        = product.title
      chb.classList.add('carousel__input')
      img             = document.createElement('img')
      img.src         = product.images[0].sizes['300']
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

  listProducts.listener = ->
    $('body').on 'change', '.carousel__input', ->
      if $(@).is ':checked'
        $(@).parent().addClass 'selected'
      else
        $(@).parent().removeClass 'selected'

  listProducts
# "https://dtvep25tfu0n1.cloudfront.net/media/resize/product/2000/67244-87d25713d51944d1b61e8bdd94cf5d23.jpeg"