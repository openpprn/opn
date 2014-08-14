class CreateAnswerSessions < ActiveRecord::Migration
  def change
    create_table :answer_sessions do |t|
      t.integer :user_id
      t.integer :question_flow_id
      t.integer :first_answer_id
      t.integer :last_answer_id

      t.timestamps
    end
  end
end
