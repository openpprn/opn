
@loaders = () ->
  null
  #socialProfileReady()


$(document).ready(loaders)
$(document).on('page:load', loaders)