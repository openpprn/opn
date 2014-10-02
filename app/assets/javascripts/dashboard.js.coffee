@dashboardReady = () ->
  $("#consent-link").popover('show')
  $("#social-profile-link").popover('show')

$(document).ready(dashboardReady)
$(document).on('page:load', dashboardReady)

$(document).on('click', () ->
  $("#consent-link").popover('hide')
  $("#social-profile-link").popover('hide')
)