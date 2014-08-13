class AnswerOption < ActiveRecord::Base
  include Localizable

  has_many :question_answer_options
  has_many :questions, through: :question_answer_options
  has_many :answer_values

  localize :text_value

  def value(data_type)
    send(data_type.to_sym)
  end
end
