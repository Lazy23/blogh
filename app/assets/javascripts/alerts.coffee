$(document).on 'turbolinks:load', ->
  $('.alert-dismissible').fadeTo(3000, 500).slideUp(500, -> $('.alert-dismissible').slideUp(500))
