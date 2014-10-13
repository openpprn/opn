class ChangeAnswerOptionsAnswerTemplateTableName < ActiveRecord::Migration
  # Yes, this migration isn't perfect best-practices, but it is needed since we have a trouble with Oracle and table names that are too long.
  # Because oracle can't handle table names as long as "answer_options_answer_templates" the first migration that created the table had to be modified.
  # There was no other way. As a result, this migration needs to handle both cases (installs that have run the old and migration and installs that have run the new)
  # The conditional logic should handle that.

  def up
    if ActiveRecord::Base.connection.table_exists? :answer_options_answer_templates
      rename_table :answer_options_answer_templates, :answer_options_templates
    end
  end

  # There is no down here because performing any change to a too long table name would error on oracle systems
end
