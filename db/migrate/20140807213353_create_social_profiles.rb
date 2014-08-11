class CreateSocialProfiles < ActiveRecord::Migration
  def change
    create_table :social_profiles do |t|
      t.string :name
      t.integer :age
      t.string :sex

      # Profile Photo
      t.string :photo
      

      # Geocoding
      t.float :latitude
      t.float :longitude
      t.string :location_id
      t.string :location
      t.boolean :show_location, default: false, null: false
      t.boolean :show_karma, default: false, null: false

      # User Foreign Key
      t.integer :user_id

      t.timestamps
    end
  end
end
