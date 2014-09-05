class VotesController < ApplicationController
  before_filter :authenticate_user!

  def vote
    if current_user.todays_votes.length < current_user.vote_quota or Question.find(params[:question_id]).group != Group.research_question_group
      v = Vote.find_or_initialize_by(user_id: current_user.id, question_id: params[:question_id])
      v.rating = params["rating"]
      v.label = params["label"]
      v.save
    end

    render nothing: true
  end



  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def object_params
    params.require(:vote).permit(:rating, :user_id, :question_id, :type)
  end
end