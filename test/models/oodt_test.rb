require "test_helper"

class OODTTest < ActiveSupport::TestCase

  def setup
    @user = users(:user_1)
  end

  def teardown
  end



  def test_oodt
    skip "because the oodt api is producing too unreliable of error messaging, it's like shooting in the dark to write these tests"
    skip_if_disabled

    @user.delete_oodt_user
    assert_not @user.oodt_user?, "User should not be a oodt user after deprovisioning"

    @user.provision_oodt_user
    assert @user.oodt_user?, "User should be a oodt user after re-provisioning"
  end

  def skip_if_disabled
    skip "OODT is not enabled so we are skipping this test, since it tests the OODT module." if !OODT_ENABLED
  end

end
