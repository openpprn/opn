@mapsReady = () ->
  if($("#user_map").length)

    loc_path = $("#user_map").data("path")

    $.getJSON(loc_path, null, (data) ->
      user_location = data.user_location

      if user_location
        centerLatlng = new google.maps.LatLng(user_location.latitude, user_location.longitude)
        zoom = 3
      else
        centerLatlng = new google.maps.LatLng(40.363882,-90.044922)
        zoom = 4

      mapOptions =
        zoom: zoom
        center: centerLatlng

      document.map = new google.maps.Map(document.getElementById("user_map"), mapOptions)


      if user_location
        new google.maps.Marker({
          icon: 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png'
          position: new google.maps.LatLng(user_location.latitude, user_location.longitude)
          map: document.map
          title: user_location.title
        })

      $.each(data.all_locations, (key, latlng) ->
        new google.maps.Marker({
          icon: 'http://maps.google.com/mapfiles/ms/icons/red-dot.png'
          position: new google.maps.LatLng(latlng.latitude, latlng.longitude),
          map: document.map
        })
      )
    )

$(document).ready(mapsReady)
$(document).on('page:load', mapsReady)

$(document).on('click', "#world-view", () ->
  document.map.setZoom(1)
)


$(document).on('click', "#country-view", () ->
  document.map.setZoom(4)
)

$(document).on('click', "#state-view", () ->
  document.map.setZoom(7)
)

$(document).on('click', "#city-view", () ->
  document.map.setZoom(13)
)