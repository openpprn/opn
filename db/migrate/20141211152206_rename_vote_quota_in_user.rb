class RenameVoteQuotaInUser < ActiveRecord::Migration
  def change
    rename_column :users, :vote_quota, :vote_modifier
    change_column_default :users, :vote_modifier, 0
  end
end
