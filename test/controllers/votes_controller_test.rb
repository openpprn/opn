require 'test_helper.rb'

class VotesControllerTest < ActionController::TestCase

  test "User should be able to vote for survey question" do
    login(users(:social))

    old_rating = questions(:q1).rating

    assert_equal old_rating, Vote.where(question_id: questions(:q1).id).count

    assert_difference "Vote.count" do
      post :vote, vote: {question_id: questions(:q1).id, rating: 1}
    end

    assert_equal questions(:q1).rating, old_rating + 1

  end

  test "User should be able to vote for research topic" do
    login(users(:social))

    old_rating = research_topics(:rt2).rating

    assert_difference "Vote.count" do
      post :vote, vote: {research_topic_id: research_topics(:rt2), cast: "1"}
    end

    assert_equal research_topics(:rt2).rating, old_rating + 1

  end

  test "User should be able to remove vote for research topic" do
    login(users(:user_1))

    old_rating = research_topics(:rt3).rating

    assert_difference "Vote.count", -1 do
      post :vote, vote: {research_topic_id: research_topics(:rt3), retract: "1"}
    end

    assert_equal research_topics(:rt3).rating, old_rating - 1


  end

  test "User should not be able to exceed vote limit" do
    login(users(:user_1))

    ENV["votes_per_user"] = '5'

    assert research_topics(:rt6).proposed?
    assert users(:user_1).can_vote_for?(research_topics(:rt6))
    assert_equal 5, ENV["votes_per_user"].to_i
    refute users(:user_1).has_votes_remaining?

    refute_difference "research_topics(:rt6).rating" do
      post :vote, vote: {research_topic_id: research_topics(:rt6), cast: "1"}
    end
  end


end