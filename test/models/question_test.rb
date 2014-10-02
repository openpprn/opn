require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  test "#answer_frequencies" do
    assert_not_nil questions(:q3a).answer_frequencies
    assert_nil questions(:q1).answer_frequencies

  end

end