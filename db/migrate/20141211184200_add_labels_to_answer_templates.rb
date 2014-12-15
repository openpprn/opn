class AddLabelsToAnswerTemplates < ActiveRecord::Migration
  def change
    add_column :answer_templates, :top_label, :string
    add_column :answer_templates, :bottom_label, :string
    add_column :answer_templates, :max_value, :integer
    add_column :answer_templates, :min_value, :integer
  end
end
