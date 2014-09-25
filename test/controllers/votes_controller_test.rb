require 'test_helper.rb'

class VotesControllerTest < ActionController::TestCase

  test "User should be able to vote for survey question" do
    skip "Test survey questions later"
    #assert false
  end

  test "User should be able to vote for research topic" do
    login(users(:social))

    old_rating = research_topics(:rt2).rating

    assert_difference "Vote.count" do
      post :vote, vote: {user_id: users(:social).id, research_topic_id: research_topics(:rt2), rating: 1}
    end

    assert_equal research_topics(:rt2).rating, old_rating + 1

  end

  test "User should be able to remove vote for research topic" do
    login(users(:user_1))


    assert_difference "research_topics(:rt3).rating", -1 do
      post :vote, vote: {user_id: users(:social).id, research_topic_id: research_topics(:rt3), rating: 0}
    end


  end



end