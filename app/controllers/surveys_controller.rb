class SurveysController < ApplicationController
  before_filter :authenticate_user!

  def start_survey
    @question_flow = QuestionFlow.find(params[:question_flow_id])
    @answer_session = AnswerSession.find_or_create_by(user_id: current_user.id, question_flow_id: @question_flow.id)
    @answer_session.reset_answers
  end

  def ask_question
    @answer_session = AnswerSession.find(params[:answer_session_id])
    @question = Question.find(params[:question_id])
    @answer = Answer.where(question_id: @question.id, answer_session_id: @answer_session.id).first || Answer.new(question_id: @question.id, answer_session_id: @answer_session.id)
  end

  def show_report
    @answer_session = AnswerSession.find(params[:answer_session_id])
    @question_flow = @answer_session.question_flow


  end

  def process_answer
    @question = Question.find(params[:question_id])
    @answer_session = AnswerSession.find(params[:answer_session_id]) # Validate user!

    answer = @answer_session.process_answer(@question, params)

    if @answer_session.completed?
      redirect_to survey_report_path(@answer_session)
    else
      redirect_to ask_question_path(question_id: answer.next_question.id, answer_session_id: @answer_session.id)
    end
  end

  def question_frequencies
    @question = Question.find(params[:question_id])
    @answer_session = AnswerSession.find(params[:answer_session_id])
  end


end
