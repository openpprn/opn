class AddExternalAccountsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :validic_id, :string
    add_column :users, :validic_access_token, :string
    add_column :users, :oodt_id, :string
  end
end
