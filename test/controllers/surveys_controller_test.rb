require 'test_helper.rb'

class SurveysControllerTest < ActionController::TestCase


  test "User can start a survey" do
    login(users(:social))

    get :start_survey, question_flow_id: question_flows(:survey_1).id

    assert_response :success


  end

  test "User can view question on survey" do
    login(users(:social))

    get :start_survey, question_flow_id: question_flows(:survey_1).id

    assert assigns(:answer_session)
    assert_response :success

    get :ask_question, question_id: question_flows(:survey_1).first_question.id, answer_session_id: assigns(:answer_session).id
    assert_response :success

  end

  test "User can answer question on survey" do
    login(users(:social))

    get :start_survey, question_flow_id: question_flows(:survey_1).id

    assert assigns(:answer_session)
    assert_response :success

    post :process_answer, { 'question_id' => question_flows(:survey_1).first_question.id, 'answer_session_id' => assigns(:answer_session).id, question_flows(:survey_1).first_question.id.to_s => "blue", "direction" => "next"}

    assert_redirected_to survey_report_path(assigns(:answer_session))
  end

  test "User can view survey report" do
    login(users(:social))

    get :start_survey, question_flow_id: question_flows(:survey_1).id
    as_id = assigns(:answer_session).id
    post :process_answer, { 'question_id' => question_flows(:survey_1).first_question.id, 'answer_session_id' => assigns(:answer_session).id, question_flows(:survey_1).first_question.id.to_s => "blue", "direction" => "next"}

    get :show_report, answer_session_id: as_id

    assert_response :success
  end

  test "User needs to be logged in to see surveys" do
    get :surveys

    assert_response 302
  end

  test "User can see a list of unstarted surveys" do
    login(users(:social))

    get :surveys

    assert_response :success
  end

end