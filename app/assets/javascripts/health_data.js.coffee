submit_check_in = (submit_path, question_id, val) ->
  post_data = {question_id: question_id}
  post_data[question_id] = val

  $.post(submit_path, post_data, (data) ->
    if data.next_question_id == null
      $("form#check-in .question").addClass("hidden")
      $("#completion_message").removeClass("hidden")
    else
      $("#completion_message").addClass("hidden")
      $("form#check-in .question").addClass("hidden")
      $("form#check-in .question[data-question-id='" + data.next_question_id + "'").removeClass('hidden')
  )


$(document).on "change", "form#check-in input[type='range'], form#check-in input[type='radio']", (event) ->
  submit_path = $("form#check-in").attr("action")
  panel = $(this).closest(".panel")
  question_id = panel.data("question-id")
  val = $(this).val()

  submit_check_in(submit_path, question_id, val)
$(document).on "click", "form#check-in .input-group .submit", (event) ->
  event.preventDefault()

  submit_path = $("form#check-in").attr("action")
  panel = $(this).closest(".panel")
  question_id = panel.data("question-id")
  val = $(this).closest(".input-group").find("input").val()

  submit_check_in(submit_path, question_id, val)
$(document).on "click", "form#check-in .prev-question", (event) ->
  event.preventDefault()

  prev_question_id = $(this).data("prev-question-id")

  console.log prev_question_id

  $("#completion_message").addClass("hidden")
  $("form#check-in .question").addClass("hidden")
  $("form#check-in .question[data-question-id='" + prev_question_id + "'").removeClass('hidden')

