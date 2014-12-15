class AddLockableToUser < ActiveRecord::Migration
  def change
    ## Lockable
    add_column :users, :failed_attempts, :integer, default: 0, null: false # Only if lock strategy is :failed_attempts
    add_column :users, :unlock_token, :string # Only if unlock strategy is :email or :both
    add_column :users, :locked_at, :datetime
  end
end
