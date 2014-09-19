class User < ActiveRecord::Base
  rolify role_join_table_name: 'roles_users'


  include Authority::UserAbilities
  include Authority::Abilities

  self.authorizer_name = "UserAuthorizer"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Model Validation
  validates_presence_of :first_name, :last_name, :zip_code, :year_of_birth
  validates_numericality_of :year_of_birth, only_integer: true, less_than_or_equal_to: -> (user){ Date.today.year - 18 }, greater_than_or_equal_to: -> (user){ 1900 }

  # Model Relationships
  has_many :answer_sessions
  has_many :answers
  has_many :votes
  has_one :social_profile
  has_many :posts

  # Named Scopes
  scope :search_by_email, ->(terms) { where("LOWER(#{self.table_name}.email) LIKE ?", terms.to_s.downcase.gsub(/^| |$/, '%')) }

  def name
    "#{first_name} #{last_name}"
  end

  def self.scoped_users(email=nil, role=nil)
    users = all

    users = users.search_by_email(email) if email.present?
    users = users.with_role(role) if role.present?

    users
  end

  def photo_url
    if social_profile and social_profile.photo.present?
      social_profile.photo.url
    else
      "//www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.to_s)}?d=identicon"
    end
  end

  def forem_name
    if social_profile and social_profile.name.present?
      social_profile.name
    else
      "Anonymous User"
    end
  end

  def to_s
    email
  end

  def created_social_profile?
    self.social_profile.present? and self.social_profile.name.present?
  end

  def signed_consent?
    self.accepted_consent_at.present?
  end

  def forem_admin?
    self.has_role? :admin
  end

  def todays_votes
    votes.select{|vote| vote.created_at.today? and vote.rating != 0 and vote.label == "research_question" }
  end

  def available_votes_percent
    (todays_votes.length.to_f / vote_quota) * 100.0
  end
end
