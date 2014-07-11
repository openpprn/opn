# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  # Add flags beside all required content
  $(".req").before("<i class='fa fa-flag requirement-flag'></i>")
  # Hide them initially
  $(".requirement-list").toggle()
  $(".requirement-flag").toggle()

  $("#requirements-toggler").bind 'click', ->
    $(".requirement-list").toggle()
    $(".requirement-flag").toggle()


