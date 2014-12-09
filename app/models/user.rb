class User < ActiveRecord::Base
  has_merit

  rolify role_join_table_name: 'roles_users'


  include Authority::UserAbilities
  include Authority::Abilities

  # Enable User Connection to External API Accounts
  include ExternalAccounts

  self.authorizer_name = "UserAuthorizer"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Model Validation
  #validates_presence_of :first_name, :last_name, :zip_code, :year_of_birth
  validates_numericality_of :year_of_birth, allow_nil: true, only_integer: true, less_than_or_equal_to: -> (user){ Date.today.year - 18 }, greater_than_or_equal_to: -> (user){ 1900 }

  # Model Relationships
  has_many :answer_sessions
  has_many :answers
  has_many :votes
  has_one :social_profile
  has_many :posts
  has_many :research_topics

  # Named Scopes
  scope :search_by_email, ->(terms) { where("LOWER(#{self.table_name}.email) LIKE ?", terms.to_s.downcase.gsub(/^| |$/, '%')) }


  # STUBS # TODO # TO IMPLEMENT
  scope :social, -> { where("1=1") } #TODO MUST DEFINE SOCIAL USERS
  def self.unique_cities_count
    self.count #FIXME #TODO #STUB
  end
  def self.health_data_streams_count
    340142 #FIXME #TODO #STUB
  end

  def name
    return "Anonymous" unless first_name && last_name
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
    # Local Consent Storage
    # self.accepted_consent_at.present?
    # OODT Consent Storage
    if OODT_ENABLED
      self.oodt_baseline_survey_complete
    else
      self.accepted_consent_at.present?
    end
  end

  def forem_admin?
    self.has_role? :admin
  end

  def can_create_forem_topics?(forum)
    self.can?(:participate_in_social)
  end

  def can_reply_to_forem_topic?(topic)
    self.can?(:participate_in_social)
  end

  def can_edit_forem_posts?(forum)
    self.can?(:participate_in_social)
  end

  def can_destroy_forem_posts?(forum)
    self.can?(:participate_in_social)
  end


  def can_moderate_forem_forum?(forum)
    self.has_role? :forum_moderator or self.has_role? :admin
  end

  def todays_votes
    votes.select{|vote| vote.updated_at.today? and vote.rating != 0 and vote.research_topic_id.present?}
  end

  def available_votes_percent
    (todays_votes.length.to_f / vote_quota) * 100.0
  end

  def is_owner?
    self.has_role? :owner
  end

  def is_admin?
    self.has_role? :admin or is_owner?
  end

  def is_moderator?
    self.has_role? :moderator or is_admin?
  end

  def incomplete_surveys
    QuestionFlow.incomplete(self)
  end

  def complete_surveys
    QuestionFlow.complete(self)
  end

  def unstarted_surveys
    QuestionFlow.unstarted(self)
  end

  def research_topics_with_vote
    ResearchTopic.voted_by(self)
  end

  def submitted_research_topics
    ResearchTopic.created_by(self)
  end


  def share_research_topics?
    true
  end

  def has_votes_remaining?(rating = 1)

    (todays_votes.length < vote_quota) or (rating < 1)
  end

  def votes_remaining_count
     vote_quota - todays_votes.length
  end

  def topics_in_top_percentile(minimum_percentage)
    all = ResearchTopic.top_research_topics(minimum_percentage)
    my_rt_ids = research_topics.map{|rt| rt.id.to_s}
    mine = all.select{|result| my_rt_ids.include?(result["research_topic_id"])}

    mine
  end
end
