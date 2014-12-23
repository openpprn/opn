require "test_helper"

class CommentTest < ActiveSupport::TestCase

  def comment
    @comment ||= Comment.new
  end

  def test_valid
    assert_not comment.valid? #comment needs a user and a body
  end

end
