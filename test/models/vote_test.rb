require "test_helper"

class VoteTest < ActiveSupport::TestCase

  test "#popular_research_questions" do
    ratings_from_fixtures = [{question: questions(:q3), rating: 5}, {question: questions(:q4), rating: 4}]
    assert_equal ratings_from_fixtures, Vote.popular_research_questions
  end


  test "#new_research_questions" do
    ratings_from_fixtures = [{question: questions(:q3), created_at: questions(:q3).created_at, rating: 5}, {question: questions(:q4), created_at: questions(:q4).created_at, rating: 4}]
    assert_equal ratings_from_fixtures, Vote.new_research_questions

  end

  test "#user_research_questions" do
    ratings_from_fixtures = [{question: questions(:q3), rating: 1}]
    assert_equal ratings_from_fixtures, Vote.user_research_questions(users(:user_6))


  end

end