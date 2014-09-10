require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase

  setup do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "a new user should be able to sign up" do
    assert_difference('User.count') do
      post :create, user: { first_name: 'First Name', last_name: 'Last Name', year_of_birth: '1980', zip_code: '12345', email: 'new_user@example.com', password: 'password', password_confirmation: 'password' }
    end

    assert_not_nil assigns(:user)
    assert_equal 'First Name', assigns(:user).first_name
    assert_equal 'Last Name', assigns(:user).last_name
    assert_equal 1980, assigns(:user).year_of_birth
    assert_equal '12345', assigns(:user).zip_code
    assert_equal 'new_user@example.com', assigns(:user).email

    assert_redirected_to user_dashboard_path
  end

  test "a new user should not be able to sign up without required fields" do
    assert_difference('User.count', 0) do
      post :create, user: { first_name: '', last_name: '', year_of_birth: '', zip_code: '', email: 'new_user@example.com', password: 'password', password_confirmation: 'password' }
    end

    assert_not_nil assigns(:user)

    assert assigns(:user).errors.size > 0
    assert_equal ["can't be blank"], assigns(:user).errors[:first_name]
    assert_equal ["can't be blank"], assigns(:user).errors[:last_name]
    assert_equal ["can't be blank", "is not a number"], assigns(:user).errors[:year_of_birth]
    assert_equal ["can't be blank"], assigns(:user).errors[:zip_code]

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
