$(document).on "click", ".voting button", () ->
  button = $(this)
  submit_path = $(this).parent().data("submit-path")
  question_path = $(this).parent().data("question-path")
  rating = $(this).data("value")
  question_id = $(this).parent().data("question-id")


  badge = $(this).siblings(".rating").first()

  $.post(submit_path, {question_id: question_id, rating: rating}, () ->
    button.siblings(".vote").first().addClass("btn-default").removeClass("btn-success").removeClass("btn-danger")


    button.removeClass("btn-default")

    if rating > 0
      button.addClass("btn-success")
    else
      button.addClass("btn-danger")

    if badge.length
      d3.json(question_path+".json", (error, q_data) ->
        badge.children().first().html(q_data.rating)
      )
  )