class VotesController < ApplicationController
  before_filter :authenticate_user!

  def vote
    if params[:vote][:research_topic_id] and current_user.can_vote_for?(ResearchTopic.find(params[:vote][:research_topic_id])) and (current_user.has_votes_remaining? || params[:vote][:rating] == "0")
      v = Vote.find_or_initialize_by(user_id: current_user.id, research_topic_id: params[:vote][:research_topic_id])
      v.rating = params[:vote]["rating"]
      saved = v.save
    elsif params[:vote][:question_id]
      v = Vote.find_or_initialize_by(user_id: current_user.id, question_id: params[:question_id])
      v.rating = params["rating"]
      v.label = params["label"]
    end

    render json: {saved: saved}
  end



  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def object_params
    params.require(:vote).permit(:rating, :user_id)
  end
end