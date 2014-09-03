@homeReady = () ->
  $("[data-toggle~='tooltip']").tooltip(
    container: 'body'
    )

  loc_path = $("#home-map").data("path")

  $.getJSON(loc_path, null, (data) ->

    centerLatlng = new google.maps.LatLng(40.363882,-95.044922)
    zoom = 3

    mapOptions =
      zoom: zoom
      center: centerLatlng

    document.map = new google.maps.Map(document.getElementById("home-map"), mapOptions)

    $.each(data.all_locations, (key, latlng) ->
      new google.maps.Marker({
        icon: '//maps.google.com/mapfiles/ms/icons/red-dot.png'
        position: new google.maps.LatLng(latlng.latitude, latlng.longitude),
        map: document.map
      })
    )
  )

$(document).ready(homeReady)
$(document).on('page:load', homeReady)
