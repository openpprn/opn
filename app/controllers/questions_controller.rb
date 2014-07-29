class QuestionsController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_question, only: [:show]

  def set_question
    @question = Question.find(params[:id])
  end
end
