require "test_helper"

class ValidicTest < ActiveSupport::TestCase


  def setup
    @user = users(:user_1)
  end


  def teardown
  end


  def test_validic
    skip_if_disabled

    @user.delete_validic_user
    assert_not @user.validic_user?, "User should not be a validic user after deprovisioning"

    @user.provision_validic_user
    assert @user.validic_user?, "User should be a validic user after re-provisioning"
  end

  def skip_if_disabled
    skip "Validic is not enabled so we are skipping this test, since it tests the Validic module." if !VALIDIC_ENABLED
  end

end
