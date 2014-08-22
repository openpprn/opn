class CreateQuestionAnswerOptions < ActiveRecord::Migration
  def change
    create_table :answer_options_questions do |t|
      t.references :question
      t.references :answer_option

      t.timestamps
    end
  end
end
