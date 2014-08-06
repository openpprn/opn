class VotesController < ApplicationController
  before_filter :authenticate_user!

  def vote
    v = Vote.find_or_initialize_by(user_id: current_user.id, question_id: params[:question_id])
    v.rating = params[:rating]
    v.save

    render nothing: true
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def object_params
    params.require(:vote).permit(:rating, :user_id, :question_id)
  end
end