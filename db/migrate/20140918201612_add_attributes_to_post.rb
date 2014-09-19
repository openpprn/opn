class AddAttributesToPost < ActiveRecord::Migration
  def change
    add_column :posts, :post_type, :string
    add_column :posts, :author, :string
    add_column :posts, :introduction, :text
  end
end
