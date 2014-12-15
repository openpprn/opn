require "test_helper"

class ResearchTopicTest < ActiveSupport::TestCase

  test "self.popular" do
    research_topics = [research_topics(:rt1), research_topics(:rt3), research_topics(:rt4), research_topics(:rt2), research_topics(:rt5), research_topics(:rt6)]
    assert_equal research_topics, ResearchTopic.popular.to_a
  end


  test "self.newest" do
    research_topics = [research_topics(:rt4), research_topics(:rt3), research_topics(:rt2), research_topics(:rt5), research_topics(:rt6), research_topics(:rt1)]
    assert_equal research_topics, ResearchTopic.newest.to_a

  end

  test "self.voted_by" do
    research_topics = [research_topics(:rt3)]
    assert_equal research_topics, ResearchTopic.voted_by(users(:user_9)).to_a


  end

  test "self.created_by" do
    research_topics = [research_topics(:rt2), research_topics(:rt6)]

    assert_equal research_topics, ResearchTopic.created_by(users(:user_2)).to_a
  end

  test "self.ranks" do
    assert_equal ResearchTopic.accepted.length, ResearchTopic.ranks.length

  end

  test "self.rank" do
    assert_equal 2, research_topics(:rt3).rank
  end
end