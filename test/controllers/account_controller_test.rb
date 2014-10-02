require 'test_helper.rb'

class AccountControllerTest < ActionController::TestCase
  test "Logged in user should get account settings" do
    login(users(:user_1))

    get :account

    assert_response :success
    assert_not_nil assigns(:user)
    assert_template layout: "account"
  end

  test "should get privacy_policy" do
    get :privacy_policy
    assert_not_nil assigns(:pc)
    assert_response :success
    assert_template layout: "myapnea/myapnea"
  end

  test "should get consent" do
    get :consent
    assert_not_nil assigns(:pc)
    assert_response :success
    assert_template layout: "myapnea/myapnea"


  end

  test "User should be able to sign consent" do
    login(users(:user_1))

    refute users(:user_1).accepted_consent_at

    get :consent

    assert_response :success
    assert_template "consent"
    assert_template layout: :dashboard


    post :consent, consent_read: true
    refute users(:user_1).reload.accepted_consent_at

    get :privacy_policy

    assert_response :success
    assert_template "privacy_policy"
    assert_template layout: :dashboard

    post :privacy_policy, agreed_to_participate: true
    assert users(:user_1).reload.accepted_consent_at

    assert_redirected_to user_dashboard_path


  end

  test "User should be able to revoke consent" do
    login(users(:social))

    assert users(:social).accepted_consent_at

    post :consent, consent_revoked: true

    refute users(:user_1).reload.accepted_consent_at

    assert_redirected_to user_dashboard_path


  end

  test "User should be able to change account information" do
    login(users(:social))
    new_last = "Boylston"
    new_first = "Jimmy"
    new_email = "new_email@new.com"
    new_zip_code = "11212"
    new_yob = 1991

    refute_equal new_last, users(:social).last_name
    refute_equal new_first, users(:social).first_name
    refute_equal new_email, users(:social).email
    refute_equal new_zip_code, users(:social).zip_code
    refute_equal new_yob, users(:social).year_of_birth

    patch :update, user: {first_name: new_first, last_name: new_last, email: new_email, zip_code: new_zip_code, year_of_birth: new_yob}

    users(:social).reload

    assert_equal new_last, users(:social).last_name
    assert_equal new_first, users(:social).first_name
    assert_equal new_email, users(:social).email
    assert_equal new_zip_code, users(:social).zip_code
    assert_equal new_yob, users(:social).year_of_birth
  end

  test "Invalid user information should render page with errors" do
    login(users(:social))
    new_yob = 1191

    patch :update, user: {year_of_birth: new_yob}

    assert_template "account"

    assert_equal :user_info, assigns(:update_for)
    assert_not_nil assigns(:user)
    assert_not_empty assigns(:user).errors

  end

  test "Terms and conditions should be visible to all without requiring login" do
    get :terms_and_conditions

    assert_response :success
    assert_template layout: 'myapnea/myapnea'
  end

  test "Terms and conditions should render dashboard layout when logged in" do
    login(users(:social))

    get :terms_and_conditions

    assert_response :success
    assert_template layout: 'dashboard'
  end

end