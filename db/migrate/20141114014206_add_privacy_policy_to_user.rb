class AddPrivacyPolicyToUser < ActiveRecord::Migration
  def change
    add_column :users, :accepted_privacy_policy_at, :datetime
    add_column :users, :accepted_terms_conditions_at, :datetime

  end
end
