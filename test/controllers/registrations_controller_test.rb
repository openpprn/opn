require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase

  setup do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "a new user should be able to sign up with only email and password" do

    assert_difference('User.count') do
      post :create, user: { email: 'new_user@example.com', password: 'password', password_confirmation: 'password' }
    end

    assert_not_nil assigns(:user)
    assert_equal 'new_user@example.com', assigns(:user).email

    assert_redirected_to research_topics_path
  end

  test "a new user should not be able to sign up without password + password comf" do
    assert_difference('User.count', 0) do
      post :create, user: { email: 'new_user@example.com'}
    end

    assert_not_nil assigns(:user)

    assert assigns(:user).errors.size > 0
    # assert_equal ["can't be blank"], assigns(:user).errors[:password_confirmation]
    assert_equal ["can't be blank"], assigns(:user).errors[:password]

    assert_template 'devise/registrations/new'
    assert_response :success
  end

  test "a new user should not be able to sign up without email" do
    assert_difference('User.count', 0) do
      post :create, user: { password: 'password', password_confirmation: 'password' }
    end

    assert_not_nil assigns(:user)

    assert assigns(:user).errors.size > 0
    assert_equal ["can't be blank"], assigns(:user).errors[:email]

    assert_template 'devise/registrations/new'
    assert_response :success
  end

  test "a new user needs to meet the age requirements" do
    assert_difference('User.count', 0) do
      post :create, user: { first_name: 'First Name', last_name: 'Last Name', year_of_birth: "#{Date.today.year - 17}", zip_code: '12345', email: 'new_user@example.com', password: 'password', password_confirmation: 'password' }
    end

    assert_not_nil assigns(:user)

    assert assigns(:user).errors.size > 0
    assert_equal ["must be less than or equal to #{Date.today.year - 18}"], assigns(:user).errors[:year_of_birth]

    assert_template 'devise/registrations/new'
    assert_response :success
  end

  test "a new user needs to be born after 1900" do
    assert_difference('User.count', 0) do
      post :create, user: { first_name: 'First Name', last_name: 'Last Name', year_of_birth: "1899", zip_code: '12345', email: 'new_user@example.com', password: 'password', password_confirmation: 'password' }
    end

    assert_not_nil assigns(:user)

    assert assigns(:user).errors.size > 0
    assert_equal ["must be greater than or equal to 1900"], assigns(:user).errors[:year_of_birth]

    assert_template 'devise/registrations/new'
    assert_response :success
  end

end
