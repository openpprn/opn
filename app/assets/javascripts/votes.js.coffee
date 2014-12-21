$(document).on "click", "#answer_session .voting button", () ->
  event.preventDefault()

  button = $(this)
  submit_path = $(this).parent().data("submit-path")
  question_path = $(this).parent().data("question-path")
  rating = $(this).data("value")
  type = $(this).parent().data("type")
  question_id = $(this).parent().data("question-id")


  badge = $(this).siblings(".rating").first()

  $.post(submit_path, {vote: {question_id: question_id, rating: rating}}, () ->
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

$(document).on "click", ".research_topics a.vote, #vote-counter a.vote, .research-topic a.vote", (event) ->
  event.preventDefault()

  link = $(this)
  link_text = ""
  badge = $(this).closest(".research-topic").find(".rating")
  console.log badge.html()
  submit_path = $(this).data("submit-path")
  research_topic_path = $(this).data("research-topic-path")
  vote_counter = $(".vote_counter")


  research_topic_id = $(this).data("research-topic-id")
  vote_hash = {research_topic_id: research_topic_id}

  if $(this).data("type") == "cast"
    vote_hash["cast"] = "1"
    link_text = "Retract Vote"
    new_data = "retract"
  else
    vote_hash["retract"] = "1"
    link_text = "Cast Vote"
    new_data = "cast"

  post_hash = {vote: vote_hash }

  $.post(submit_path, post_hash, (data) ->
    if data.saved
      if $(this).data("type") == 'retract-counter'
        $(this).closest(".list-group-item").remove()
      else
        link.text(link_text)
        link.toggleClass('btn-primary').toggleClass("btn-default")
        link.data("type", new_data)
      if badge.length
        $.getJSON(research_topic_path+".json", (data) ->
          badge.html(data.rating)
        )

      if vote_counter.length
        $.get(vote_counter.data("target-path"), (data) ->
          vote_counter.html(data)
        )
    else
      console.log data
      bootbox.alert("Sorry! You have used all your votes. If you want to vote for this topic, first retract a vote from another.")


  )

$(document).on "click", ".research_topics a.disabled", (event) ->
  event.preventDefault()


#$(document).on "show.bs.tab", 'a[data-toggle="tab"]', (event) ->
#
#   target_path = $(event.target).data("target-path")
#   target_pane = $($(event.target).attr("href"))
#   target_pane.hide()
#
#   id = target_pane.attr("id")
#
#   $.get(target_path, { id: id}, (data) ->
#     target_pane.html(data)
#     target_pane.show()
#   )
