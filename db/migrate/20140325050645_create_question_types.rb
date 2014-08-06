class CreateQuestionTypes < ActiveRecord::Migration
  def change
    create_table :question_types do |t|
      t.string :name
      t.string :tag
      t.string :input_type
      t.boolean :store_raw_value
      t.boolean :allow_multiple

      t.timestamps
    end
  end
end
