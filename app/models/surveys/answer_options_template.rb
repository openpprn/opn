class AnswerOptionsTemplate < ActiveRecord::Base
  belongs_to :answer_template
  belongs_to :answer_option
end
