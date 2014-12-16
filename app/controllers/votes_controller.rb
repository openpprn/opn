class VotesController < ApplicationController
  before_filter :authenticate_user!

  def vote
    success = false

    if params[:vote][:research_topic_id]
      if params[:vote][:cast] and current_user.can_vote_for?(ResearchTopic.find(params[:vote][:research_topic_id])) and current_user.has_votes_remaining?
        @vote = Vote.find_or_initialize_by(user_id: current_user.id, research_topic_id: params[:vote][:research_topic_id])
        @vote.rating = 1 # REFACTOR LATER
        saved = @vote.save


      elsif params[:vote][:retract] and current_user.can_vote_for?(ResearchTopic.find(params[:vote][:research_topic_id]))
        @vote = Vote.find_by(user_id: current_user.id, research_topic_id: params[:vote][:research_topic_id])
        saved = @vote.delete
      end

    elsif params[:vote][:question_id]
      @vote = Vote.find_or_initialize_by(user_id: current_user.id, question_id: params[:vote][:question_id])
      @vote.rating = params[:vote]["rating"]
      saved = @vote.save

    end

    render json: {saved: saved}
  end



  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def object_params
    params.require(:vote).permit(:rating)
  end
end