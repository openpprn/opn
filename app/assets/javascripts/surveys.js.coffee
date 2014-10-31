@surveysReady = () ->

  if $(".question-form .typeahead").length > 0
    @institutions = new Bloodhound(
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace("value")
      queryTokenizer: Bloodhound.tokenizers.whitespace
      prefetch: $(".question-form").data("typeahead-path") + ".json"
    )

    @institutions.initialize()

    $(".question-form .typeahead").typeahead null,
      name: "institutions"
      displayKey: "value"
      source: institutions.ttAdapter()


