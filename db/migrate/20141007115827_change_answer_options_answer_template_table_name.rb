class ChangeAnswerOptionsAnswerTemplateTableName < ActiveRecord::Migration
  # Yes, this migration isn't perfect best-practices, but it is needed since we have a trouble with Oracle and table names that are too long.
  # Because oracle can't handle table names as long as "answer_options_answer_templates" the first migration that created the table had to be modified.
  # There was no other way. As a result, this migration needs to handle both cases (installs that have run the old and migration and installs that have run the new)
  # The conditional logic should handle that.

  ## Oracle Naming Standards:
  ## Table Standards

  # All table names will be plural (e.g. users vs. user).
  # Full table names will be used whenever possible.
  # If a table name should exceed 30 characters, reduce the size of the table name in this order:
  # From the left of the table name, remove vowels from each word in the table name except for the first vowel of each word.
  #                                                                                                                                                                                                                                                                                                If the table name is still greater than 30 characters, use standardized shorthand indicators. Record this standard for consistent use.

  def up
    if ActiveRecord::Base.connection.table_exists? :answer_options_answer_templates
      rename_table :answer_options_answer_templates, :answr_options_answer_templates
    end
  end

  # There is no down here because performing any change to a too long table name would error on oracle systems
end
