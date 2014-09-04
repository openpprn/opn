require 'test_helper.rb'

class AdminControllerTest < ActionController::TestCase

  test "Owners should GET user administration" do
    login(users(:owner))

    get :users
    assert_response :success

  end

  test "Admins should GET user administration" do
    login(users(:admin))

    get :users
    assert_response :success

  end

  test "should raise SecurityViolation for unauthorized users" do
    login(users(:user_1))

    get :users

    assert_authorization_exception
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
    assert_authorization_exception
    refute users(:user_1).has_role? :admin

    post :remove_role_from_user, user_id: users(:admin).id, role: roles(:admin).name, format: :js
    assert_authorization_exception
    assert users(:admin).has_role? :admin

    login(users(:user_1))

    post :add_role_to_user, format: :js, user_id: users(:user_1).id, role: roles(:admin).name
    assert_authorization_exception
    refute users(:user_1).has_role? :admin

    post :remove_role_from_user, user_id: users(:admin).id, role: roles(:admin).name, format: :js
    assert_authorization_exception
    assert users(:admin).has_role? :admin


  end

  test "should allow owner to delete users" do
    login(users(:owner))
    post :destroy_user, user_id: users(:user_1).id, format: :js
    assert_response :success
    refute User.find_by_id(users(:user_1).id)

    post :destroy_user, user_id: users(:admin).id, format: :js
    assert_response :success
    refute User.find_by_id(users(:admin).id)

  end

  test "should not allow owner to delete himself" do
    login(users(:owner))
    post :destroy_user, user_id: users(:owner).id, format: :js


    assert_response :success
    assert User.find_by_id(users(:owner).id)

  end

  test "should not allow non-owner to delete users" do
    login(users(:admin))

    post :destroy_user, user_id: users(:user_1).id, format: :js
    assert_authorization_exception
    post :destroy_user, user_id: users(:owner).id, format: :js
    assert_authorization_exception
    post :destroy_user, user_id: users(:admin).id, format: :js
    assert_authorization_exception

    login(users(:user_5))
    post :destroy_user, user_id: users(:user_1).id, format: :js
    assert_authorization_exception
    post :destroy_user, user_id: users(:owner).id, format: :js
    assert_authorization_exception
    post :destroy_user, user_id: users(:admin).id, format: :js
    assert_authorization_exception

  end


  def assert_authorization_exception
    assert_response 302
    assert flash[:alert]
  end

end