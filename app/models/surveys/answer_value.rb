class AnswerValue < ActiveRecord::Base
  belongs_to :answer
  belongs_to :answer_option
  belongs_to :answer_template

  def value
    self[answer_template.data_type]
  end

  def string_value
    value.to_s
  end

  def show_value
    if answer_template.data_type == 'answer_option_id'
      answer_option.present? ? answer_option.value : nil
    else
      value
    end
  end
end
