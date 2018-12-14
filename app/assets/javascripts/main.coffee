# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.snack = (options)->
  document.querySelector("#global-snackbar")
    .MaterialSnackbar.showSnackbar(options)

$(document).on 'turbolinks:load', ()->
  componentHandler.upgradeDom()

$(document).on "page:load page:fetch ready", ()->
  # componentHandler.upgradeDom()

  $(".close-parent").on "click", (ev)->
    $(this).parent().slideUp()

  $("#notification").on "click", (ev)->
    # si las notificaciones visibles, preventDefault()
    ev.preventDefault() if $("#notifications").hasClass("active")

    # se cambia el estado
    $("#notifications").toggleClass("active")

    # si tiene la clase active es porque no la tenía
    # si no la tiene es porque antes sí la tenía
    return $("#notifications").hasClass("active")

  $(".best_in_place").best_in_place()
  
  $('.mdl-layout').scroll ->
    if !window.loading && $('.mdl-layout').scrollTop() > ($(document).height() / 2) - 100
      window.loading = true
      url = $('.next_page').attr('href')
      $.getScript url if url
      