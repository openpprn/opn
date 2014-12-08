$(document).on "click", ".table.topics tr", (event) ->
  document.location = $(this).data("href")  if $(this).data("href") isnt `undefined`
  return

