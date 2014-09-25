require "test_helper"

class VoteTest < ActiveSupport::TestCase
  before do
    skip "too tired"
  end

  test "#popular_research_questions" do
    ratings_from_fixtures = [{question: questions(:q3), rating: 5}, {question: questions(:q4), rating: 4}, {question: questions(:q5), rating: 0}, {question: questions(:q6), rating: 0}]
    assert_equal ratings_from_fixtures, Vote.popular_research_questions
  end


  test "#new_research_questions" do
    ratings_from_fixtures = [{question: questions(:q3), created_at: questions(:q3).created_at, rating: 5}, {question: questions(:q4), created_at: questions(:q4).created_at, rating: 4}, {question: questions(:q5), created_at: questions(:q5).created_at, rating: 0}, {question: questions(:q6), created_at: questions(:q6).created_at, rating: 0}]
    assert_equal ratings_from_fixtures, Vote.new_research_questions

  end

  test "#user_research_questions" do
    ratings_from_fixtures = [{question: questions(:q3), rating: 1}]
    assert_equal ratings_from_fixtures, Vote.user_research_questions(users(:user_6))


  end

end