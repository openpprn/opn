class CreateQuestionFlows < ActiveRecord::Migration
  def change
    create_table :question_flows do |t|
      t.string :name_en
      t.string :name_es
      t.text :description_en
      t.text :description_es
      t.integer :first_question_id
      t.string :status
      t.text :tsorted_edges
      t.decimal :longest_time
      t.integer :longest_path

      t.timestamps
    end
  end
end
