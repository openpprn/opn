class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text_en
      t.text :text_es
      t.integer :question_type_id
      t.integer :question_help_message_id
      t.integer :answer_type_id
      t.integer :unit_id
      t.integer :group_id
      t.decimal :time_estimate

      t.timestamps
    end
  end
end
