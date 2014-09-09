class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text_en
      t.text :text_es
      t.references :question_help_message
      t.integer :group_id
      t.decimal :time_estimate

      t.timestamps
    end
  end
end
