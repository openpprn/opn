class SocialProfile < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  belongs_to :user

  validates_uniqueness_of :name, allow_blank: true, case_sensitive: false
  validates :age, numericality: {only_integer: true, less_than_or_equal_to: 120, allow_nil: true, greater_than_or_equal_to: 1}
  validates :sex, inclusion: { in: %w(Male Female Other), allow_nil: true}

  def self.locations_for_map(user=nil)
    res = select(:latitude, :longitude).where(show_location: true)
    res = res.where.not(id: user.social_profile.id) if user and user.social_profile

    res.map{|geo| {latitude: geo.latitude, longitude: geo.longitude} }
  end


  def show_publicly?
    make_public?
  end

  def photo_url
    if show_publicly? and photo.present?
      photo.url
    else
      "//www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.to_s)}?d=identicon"
    end
  end

  def public_location
    if show_publicly?
      location
    else
      "Anonymous Location"
    end
  end

  def public_nickname
    if show_publicly? and name.present?
      name
    else
      "Anonymous User #{Digest::MD5.hexdigest(user.email.to_s)[0,5]}"
    end
  end

  def location_for_map
    if latitude and longitude
      { latitude: latitude, longitude: longitude, title: name }
    else
      nil
    end
  end
end
