class AnswerOptionsAnswerTemplate < ActiveRecord::Base
  self.table_name = 'answr_options_answer_templates'

  belongs_to :answer_template
  belongs_to :answer_option
end
