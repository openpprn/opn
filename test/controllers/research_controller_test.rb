require 'test_helper.rb'

class ResearchControllerTest < ActionController::TestCase
  test "User needs to be logged in to see surveys" do
    get :research_surveys

    assert_response 302
  end

  test "User can see a list of unstarted surveys" do
    login(users(:social))

    get :research_surveys

    assert_response :success
  end


  test "User can view research topics" do
    login(users(:user_1))

    get :research_topics

    assert_response :success
  end

  test "User can view single research topic" do
    login(users(:user_1))

    get :research_question, id: questions(:q3).id

    assert_not_nil assigns(:question)
    assert_response :success
  end
  #test "User can see a list of completed surveys" do
  #  login(users(:completed_survey))
  #
  #end
  #
  #test "User can see a list of incomplete surveys" do
  #  login(users(:incomplete_survey))
  #
  #
  #end

end