class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name_en
      t.string :name_es

      t.timestamps
    end
  end
end
