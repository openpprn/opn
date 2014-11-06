class ChangeAnswerOptionsTemplateTableName < ActiveRecord::Migration
  # This is an intermediary fix for anyone who ran the migration that switched the table name to answer_options_templates.

  def up
    if ActiveRecord::Base.connection.table_exists? :answer_options_templates
      rename_table :answer_options_templates, :answr_options_answer_templates
    end
  end

  # There is no down here because performing any change to a too long table name would error on oracle systems
end
