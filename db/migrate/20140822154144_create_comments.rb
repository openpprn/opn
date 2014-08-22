class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.string :state

      t.references :user
      t.references :post, null: false

      t.timestamps
    end
    add_index :comments, :post_id
  end
end
