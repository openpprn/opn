class ChangeAnswerOptionsAnswerTemplateTableName < ActiveRecord::Migration
  def change
    rename_table :answer_options_answer_templates, :answer_options_templates
    # through a code change to the model, the associated model now references this table (rather than using the default rails naming convention to assume its name)
  end
end
