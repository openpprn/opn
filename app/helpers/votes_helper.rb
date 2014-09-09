module VotesHelper
  def vote_class(question, rating)
    if question.has_vote?(current_user, rating)
      if rating > 0
        "btn-success"
      else
        "btn-danger"
      end
    else
      "btn-default"
    end
  end

  def checkbox_class(question)
    if current_user and question.has_vote?(current_user, 1)
      "fa-check-square-o"
    else
      "fa-square-o"
    end
  end
end
