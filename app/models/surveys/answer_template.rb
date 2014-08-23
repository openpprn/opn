class AnswerTemplate < ActiveRecord::Base
  has_many :questions, through: :answer_templates_questions
  has_many :answer_options_answer_templates, -> { order "answer_options_answer_templates.created_at" }
  has_many :answer_options, through: :answer_options_answer_templates
end
