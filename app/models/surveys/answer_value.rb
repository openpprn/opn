class AnswerValue < ActiveRecord::Base
  belongs_to :answer
  belongs_to :answer_option
end
