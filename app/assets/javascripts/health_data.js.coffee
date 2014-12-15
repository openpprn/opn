$(document).on "change", "form#check-in input", (event) ->
  console.log "AHEM"
  submit_path = $("form#check-in").attr("action")
  panel = $(this).closest(".panel")
  question_id = panel.data("question-id")
  val = $(this).val()
  post_data = {question_id: question_id}
  post_data[question_id] = val

  console.log question_id
  console.log val

  $.post(submit_path, post_data, (data) ->

    console.log "SUBMITTED"
    console.log data
  )
