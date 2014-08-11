@mapsReady = () ->
  if($("#user_map").length)
    myLatlng = new google.maps.LatLng(40.363882,-90.044922)
    mapOptions =
      zoom: 3
      center: myLatlng

    map = new google.maps.Map(document.getElementById("user_map"), mapOptions)

    loc_path = $("#user_map").data("path")

    $.getJSON(loc_path, null, (data) ->
      $.each(data, (key, latlng) ->
        markerLatlng = new google.maps.LatLng(latlng.latitude, latlng.longitude)
        new google.maps.Marker({
          position: markerLatlng,
          map: map
        });
      )
    )

$(document).ready(mapsReady)
$(document).on('page:load', mapsReady)