class AnswerTemplate < ActiveRecord::Base
  has_and_belongs_to_many :questions
  has_many :answer_options_answer_templates, -> { order "answr_options_answer_templates.created_at" }
  has_many :answer_options, through: :answer_options_answer_templates, join_table: 'answr_options_answer_templates'
  belongs_to :display_type
  belongs_to :unit




end
