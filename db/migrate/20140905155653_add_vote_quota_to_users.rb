class AddVoteQuotaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :vote_quota, :integer, default: 5;



  end
end
