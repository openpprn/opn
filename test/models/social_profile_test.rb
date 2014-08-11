require "test_helper"

class SocialProfileTest < ActiveSupport::TestCase

  def social_profile
    @social_profile ||= SocialProfile.new
  end

  def test_valid
    assert social_profile.valid?
  end

end
