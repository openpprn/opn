class SocialProfile < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  belongs_to :user

  validates :age, numericality: {only_integer: true, less_than_or_equal_to: 120, allow_nil: true}
  validates :sex, inclusion: { in: %w(Male Female Other), allow_nil: true}


  def self.locations_for_map(user)
    res = select(:latitude, :longitude).where(show_location: true)
    res = res.where.not(id: user.social_profile.id) if user and user.social_profile

    res.map{|geo| {latitude: geo.latitude, longitude: geo.longitude} }
  end


  def location_for_map
    if latitude and longitude
      { latitude: latitude, longitude: longitude, title: name }
    else
      nil
    end
  end
end
