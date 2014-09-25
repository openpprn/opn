require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "Moderator can create a new post" do
    login(users(:moderator_1))

    assert_difference "Post.count" do
      post :create, post: {title: "Some title", author: "Some author", body: "Body"}
    end

  end

  test "Non-moderator cannot create a new post" do
    login(users(:user_1))

    refute_difference "Post.count" do
      post :create, post: {title: "Some title", author: "Some author", body: "Body"}
    end

  end

  test "Moderator can delete post" do
    login(users(:moderator_1))

    assert_difference "Post.count", -1 do
      delete :destroy, id: posts(:accepted_blog_post).id
    end
  end

  test "Moderator can update post" do
    login(users(:moderator_2))

    new_attrs = {title: "New title", state: "accepted" }
    patch :update, post: new_attrs, id: posts(:draft_blog_post).id

    posts(:draft_blog_post).reload
    assert_equal new_attrs[:state], posts(:draft_blog_post).state
    assert_equal new_attrs[:title], posts(:draft_blog_post).title
  end

  test "Non-moderator cannot update post" do
    login(users(:user_2))

    new_attrs = {title: "New title", state: "accepted" }
    patch :update, post: new_attrs, id: posts(:draft_blog_post).id

    posts(:draft_blog_post).reload
    assert_not_equal new_attrs[:state], posts(:draft_blog_post).state
    assert_not_equal new_attrs[:title], posts(:draft_blog_post).title

  end

  test "Non-moderator cannot delete post" do
    login(users(:user_1))

    refute_difference "Post.count", -1 do
      delete :destroy, id: posts(:accepted_blog_post).id
    end

  end

end