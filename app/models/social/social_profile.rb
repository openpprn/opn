class SocialProfile < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  belongs_to :user

  validates :age, numericality: {only_integer: true, less_than_or_equal_to: 120, allow_nil: true}
  validates :sex, inclusion: { in: %w(Male Female Other), allow_nil: true}


  def self.locations_for_map
    select(:latitude, :longitude).where(show_location: true).map{|geo| {latitude: geo.latitude, longitude: geo.longitude} }
  end

end
