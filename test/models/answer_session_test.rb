require "test_helper"

class AnswerSessionTest < ActiveSupport::TestCase

  test "#grouped_reportable_answers" do
    assert_not_empty answer_sessions(:complete).grouped_reportable_answers
  end


end