require 'test_helper.rb'

class AccountControllerTest < ActionController::TestCase

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



end