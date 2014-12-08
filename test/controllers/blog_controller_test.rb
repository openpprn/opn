require 'test_helper'

class BlogControllerTest < ActionController::TestCase
  test "User can see only accepted posts" do
    skip "Blog functionality under construction"

    login(users(:user_1))

    get :blog

    assert_equal [posts(:accepted_blog_post)], assigns(:posts)
  end

end