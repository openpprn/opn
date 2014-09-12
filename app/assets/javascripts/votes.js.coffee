$(document).on "click", "#answer_session .voting button", () ->
  event.preventDefault()

  button = $(this)
  submit_path = $(this).parent().data("submit-path")
  question_path = $(this).parent().data("question-path")
  rating = $(this).data("value")
  type = $(this).parent().data("type")
  question_id = $(this).parent().data("question-id")


  badge = $(this).siblings(".rating").first()

  $.post(submit_path, {question_id: question_id, rating: rating, type: type}, () ->
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

$(document).on "click", ".research_topics a.voting", () ->
  event.preventDefault()

  link = $(this)
  icon = link.children().first()
  badge = $(this).closest(".research_question").find(".question-rating")
  submit_path = $(this).data("submit-path")
  question_path = $(this).data("question-path")
  vote_counter = $(".vote_counter")

  if icon.hasClass('fa-square-o')
    rating = 1
  else
    rating = 0
  label = $(this).data("type")
  question_id = $(this).data("question-id")


  $.post(submit_path, {question_id: question_id, rating: rating, label: label}, (data) ->
    if data.saved
      icon.toggleClass('fa-square-o').toggleClass("fa-check-square-o")

      if badge.length
        $.getJSON(question_path+".json", (data) ->
          badge.html(data.rating)
        )

      if vote_counter.length
        $.get(vote_counter.data("target-path"), (data) ->
          vote_counter.html(data)
        )
    else
      alert("Sorry! You have already used all of your votes for today.")


  )

$(document).on "show.bs.tab", 'a[data-toggle="tab"]', (event) ->

  target_path = $(event.target).data("target-path")
  target_pane = $($(event.target).attr("href"))
  target_pane.hide()

  id = target_pane.attr("id")

  $.get(target_path, { id: id}, (data) ->
    target_pane.html(data)
    target_pane.show()
  )