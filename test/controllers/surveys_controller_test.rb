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
    assert_not_nil assigns(:answer)

  end

  test "User can view grouped question on survey" do
    login(users(:has_incomplete_survey))

    get :ask_question, question_id: questions(:q3b).id, answer_session_id: answer_sessions(:incomplete).id

    assert_response :success
    assert_not_nil assigns(:group)
    assert_not_nil assigns(:questions)
  end

  test "User can answer question on survey" do
    login(users(:has_incomplete_survey))
    assert users(:has_incomplete_survey).can?(:participate_in_research)

    post :process_answer, { 'question_id' => questions(:q3c).id, 'answer_session_id' => answer_sessions(:incomplete).id,  questions(:q3c).id.to_s => 22, "direction" => "next"}

    assert_not_nil assigns(:answer_session)

    assert_redirected_to survey_report_path(assigns(:answer_session))
  end

  test "User can view survey report" do
    login(users(:has_completed_survey))

    get :show_report, answer_session_id: answer_sessions(:complete)

    assert_response :success
  end

  test "Survey report does not break when survey not started" do
    login(users(:has_unstarted_survey))


    get :show_report, answer_session_id: answer_sessions(:unstarted)

    assert_response :success
  end

  test "Surveys cannot be restarted once they are completed without explicit warning" do
    login(users(:has_completed_survey))

    get :start_survey, question_flow_id: question_flows(:survey_1).id

    assert_redirected_to surveys_path

  end

  test "Surveys can be restarted when verified by user" do
    login(users(:has_completed_survey))

    get :start_survey, question_flow_id: question_flows(:survey_1).id, reset_survey: true

    assert_response :success
    assert_equal users(:has_completed_survey).complete_surveys.length, 0

  end
end