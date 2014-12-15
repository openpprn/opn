class ActsAsCommentableWithThreadingMigration < ActiveRecord::Migration
  def self.up
    drop_table :comments

    create_table :comments, :force => true do |t|
      t.integer :commentable_id
      t.string :commentable_type
      t.string :title
      t.text :body
      t.string :subject
      t.integer :user_id, :null => false
      t.integer :parent_id, :lft, :rgt
      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, [:commentable_id, :commentable_type]
  end

  def self.down
    drop_table :comments

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
