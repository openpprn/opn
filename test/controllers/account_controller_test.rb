require 'test_helper.rb'

class AccountControllerTest < ActionController::TestCase


  test "User should be able to sign consent" do
    login(users(:user_1))

    refute users(:user_1).accepted_consent_at

    get :consent

    assert_response :success
    assert_template "consent"

    post :consent, consent_signed: true
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