class AnswerOption < ActiveRecord::Base
  include Localizable

  has_many :answer_templates, through: :answer_options_answer_templates, join_table: :answr_options_answer_templates
  has_many :answer_values

  localize :text_value

  def value
    text_value || time_value || numeric_value
  end
end
