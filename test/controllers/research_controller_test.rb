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



  test "User can see a list of completed surveys" do
    login(users(:has_completed_survey))

    get :research_surveys

    assert_response :success
    assert_not_nil assigns(:complete_surveys)
    assert_not_empty assigns(:complete_surveys)

  end

  test "User can see a list of incomplete surveys" do
    login(users(:has_incomplete_survey))

    get :research_surveys

    assert_response :success
    assert_not_nil assigns(:incomplete_surveys)
    assert_not_empty assigns(:incomplete_surveys)

  end

end