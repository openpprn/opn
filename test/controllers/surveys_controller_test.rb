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
    login(users(:has_incomplete_survey))

    post :process_answer, { 'question_id' => questions(:q2a).id, 'answer_session_id' => answer_sessions(:incomplete).id,  questions(:q2a).id.to_s => "blue", "direction" => "next"}

    assert_redirected_to survey_report_path(assigns(:answer_session))
  end

  test "User can view survey report" do
    login(users(:has_completed_survey))

    get :show_report, answer_session_id: answer_sessions(:complete)

    assert_response :success
  end
end