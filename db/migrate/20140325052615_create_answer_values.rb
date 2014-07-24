class CreateAnswerValues < ActiveRecord::Migration
  def change
    create_table :answer_values do |t|
      t.integer :answer_id
      t.integer :answer_option_id
      t.decimal :numeric_value
      t.string :text_value
      t.datetime :time_value

      t.timestamps
    end
  end
end
