require 'test_helper.rb'

class AdminControllerTest < ActionController::TestCase

  test "should GET dashboard for owners" do
    login(users(:owner))

    get :dashboard
    assert_response :success

  end

  test "should GET dashboard for admins" do
    login(users(:admin))

    get :dashboard
    assert_response :success

  end

  test "should raise SecurityViolation for unauthorized users" do
    login(users(:user_1))

    get :dashboard
    assert_response 403
  end

  test "should allow owner to add and remove user roles" do
    login(users(:owner))

    post :add_role_to_user, format: :js, user_id: users(:user_1).id, role: roles(:admin).name
    assert_response :success
    assert users(:user_1).has_role? :admin

    post :remove_role_from_user, user_id: users(:admin).id, role: roles(:admin).name, format: :js
    assert_response :success
    refute users(:admin).has_role? :admin
  end

  test "should not allow a non-owner to add and remove user roles" do
    login(users(:admin))

    post :add_role_to_user, format: :js, user_id: users(:user_1).id, role: roles(:admin).name
    assert_response 403
    refute users(:user_1).has_role? :admin

    post :remove_role_from_user, user_id: users(:admin).id, role: roles(:admin).name, format: :js
    assert_response 403
    assert users(:admin).has_role? :admin

    login(users(:user_1))

    post :add_role_to_user, format: :js, user_id: users(:user_1).id, role: roles(:admin).name
    assert_response 403
    refute users(:user_1).has_role? :admin

    post :remove_role_from_user, user_id: users(:admin).id, role: roles(:admin).name, format: :js
    assert_response 403
    assert users(:admin).has_role? :admin


  end


end