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
end
