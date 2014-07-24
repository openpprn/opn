class CreateAnswerEdges < ActiveRecord::Migration
  def change
    create_table :answer_edges do |t|
      t.integer :parent_answer_id
      t.integer :child_answer_id
      t.integer :answer_session_id

      t.timestamps
    end
  end
end
