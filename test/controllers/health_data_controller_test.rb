require 'test_helper.rb'

class HealthDataControllerTest < ActionController::TestCase

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

