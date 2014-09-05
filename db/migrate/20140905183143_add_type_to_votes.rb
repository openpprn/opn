class AddTypeToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :label, :string
  end
end
