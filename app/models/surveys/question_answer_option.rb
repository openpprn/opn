class QuestionAnswerOption < ActiveRecord::Base
  belongs_to :question
  belongs_to :answer_option
end
