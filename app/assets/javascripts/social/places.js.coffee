@addressPicker = new AddressPicker(
  autocompleteService: {
    types: ['(regions)'],
  }
);
@writeResults = (result) ->
  $("#social_profile_latitude").val(result.lat())
  $("#social_profile_longitude").val(result.lng())
  $("#social_profile_location_id").val(result.placeResult.place_id)


@placesReady = () ->
  addressPicker.bindDefaultTypeaheadEvent($('#location'))

  $("#location").typeahead(null, {
    displayKey: 'description',
    source: addressPicker.ttAdapter()
  });



  $(addressPicker).on "addresspicker:selected", (event, result) ->
    writeResults(result)


$(document).ready(placesReady)
$(document).on('page:load', placesReady)