class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.with_options(null: false) do |r|
        r.string :title
        r.text :body
        r.string :state, default: 'draft'
        r.integer :comments_count, default: 0
      end
      t.references :user
      t.timestamps
    end
  end
end
