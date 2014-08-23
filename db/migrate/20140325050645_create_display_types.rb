class CreateDisplayTypes < ActiveRecord::Migration
  def change
    create_table :display_types do |t|
      t.string :name
      t.string :tag
      t.string :input_type
      t.string :class

      t.timestamps
    end
  end
end
