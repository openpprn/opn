class CreateQuestionAnswerOptions < ActiveRecord::Migration
  def change
    create_table :question_answer_options do |t|
      t.integer :question_id
      t.integer :answer_option_id

      t.timestamps
    end
  end
end
