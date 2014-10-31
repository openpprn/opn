class AddClassToDisplayType < ActiveRecord::Migration
  def change
    add_column :display_types, :class_string, :string
  end
end
