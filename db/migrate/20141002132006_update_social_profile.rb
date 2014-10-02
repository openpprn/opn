class UpdateSocialProfile < ActiveRecord::Migration
  def change
    # More options for visibility and privacy
    # Forem, Research Topics, Map for community, outside.

    add_column :social_profiles, :visible_to_community, :boolean, default: false, null: false
    add_column :social_profiles, :visible_to_world, :boolean, default: false, null: false
  end
end
