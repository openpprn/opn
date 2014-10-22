require 'test_helper.rb'


class Forem::ForumsControllerTest < ActionController::TestCase
  test 'Non-logged in user should be able to see forem' do
    get :index, use_route: :forem

    assert_response :success
  end
end
