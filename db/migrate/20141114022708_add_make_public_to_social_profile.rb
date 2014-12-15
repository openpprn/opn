class AddMakePublicToSocialProfile < ActiveRecord::Migration
  def change
    add_column :social_profiles, :make_public, :boolean, default: false, null: false
  end
end
