class AnswerValue < ActiveRecord::Base
  belongs_to :answer
  belongs_to :answer_option
  belongs_to :answer_template

  def value
    self[answer_template.data_type]
  end

  def show_value
    if answer_template.data_type == 'answer_option_id'
      answer_option.value
    else
      value
    end
  end
end
