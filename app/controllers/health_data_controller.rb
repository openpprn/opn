class HealthDataController < ApplicationController
  before_action :authenticate_user!, :only => [:data_explore, :data_reports, :medications]
  before_action :set_active_top_nav_link_to_health_data
  before_action :validate_oodt_module, :only => [:explore, :reports]
  before_action :validate_validic_module, :only => []
  before_action :check_in_setup

  layout "health_data"

  def validate_oodt_module
    raise "OODT must be enabled for this feature." if !Figaro.env.oodt_enabled
  end

  def validate_validic_module
    raise "Validic must be enabled for this feature." if !Figaro.env.validic_enabled
  end

  def my_dashboard
    @med_list = (current_user and ENV["oodt_enabled"]) ? current_user.get_med_list : {}
  end

  def my_health_measures
    @chart_urls = (current_user and ENV["oodt_enabled"]) ? current_user.get_chart_urls : {}
  end


  def submit_check_in
    params[:question_id]
    params[:value]
  end

  def check_in

    question = Question.find(params[:question_id])

    @answer = @answer_session.process_answer(question, params)

    render json: {answer: @answer, next_question_id: (@answer.next_question.id if @answer and @answer.next_question)}


  end


  private

  def check_in_setup
    @question_flow = QuestionFlow.find_by_name_en("Daily Trends")
    @answer_session = AnswerSession.most_recent(@question_flow.id, current_user.id)

    if @answer_session.nil? or (@answer_session.completed? and (Time.zone.now - @answer_session.updated_at) >= Figaro.env.daily_trend_frequency.to_i * 3600) or params[:new_check_in]
      #raise StandardError
      @answer_session = AnswerSession.create(user_id: current_user.id, question_flow_id: @question_flow.id)
    end

  end


end
