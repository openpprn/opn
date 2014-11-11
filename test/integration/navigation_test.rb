require 'test_helper'

SimpleCov.command_name "test:integration"

class NavigationTest < ActionDispatch::IntegrationTest
  fixtures :users

  def setup
    @valid = users(:user_1)
  end

  test "should get root path" do
    get "/"
    assert_equal '/', path
  end

  test "should get discussion forum" do
    get members_path
    assert_equal members_path, path
  end

end
