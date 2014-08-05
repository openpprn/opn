require 'test_helper.rb'

class PagesControllerTest < ActionController::TestCase

  test "should get about" do
    get :about
    assert_response :success
  end

end
