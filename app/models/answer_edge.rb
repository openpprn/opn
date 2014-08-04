class AnswerEdge < ActiveRecord::Base
  belongs_to :parent_answer, class_name: "Answer"
  belongs_to :child_answer, class_name: "Answer"
  belongs_to :answer_session
end
