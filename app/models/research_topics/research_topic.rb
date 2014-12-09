class ResearchTopic < ActiveRecord::Base
  include Votable
  has_many :votes

  paginates_per 5

  include Authority::Abilities

  belongs_to :user

  STATES = [:proposed, :under_study, :study_completed, :removed]
  #Old Implementation: STATES = [:under_review, :proposed, :accepted, :rejected, :complete, :hidden]

  scope :proposed, -> { where(state: 'proposed') }
  scope :under_study, -> { where(state: 'under_study') }
  scope :study_completed, -> { where(state: 'study_completed') }
  scope :removed, -> { where(state: 'removed') }

  scope :sorted, -> { order(:votes_count)}

  # intentionally returns all now, to allow for future filtering (no filters needed at the moment):
  scope :viewable_by, lambda { |user_id| self.all}


  def self.popular(user_id = nil) #FIXME inefficient at high record numbers
    viewable_by(user_id).includes(:votes).sort do |rt1, rt2|
      sort_topics(rt1, rt2)
    end
  end

  def self.most_active(user_id = nil) #FIXME inefficient at high record numbers
    order(updated_at: :desc)
  end


  def self.voted_by(user)
    self.joins(:votes).where(votes: {user_id: user.id, rating: 1} ).sort do |rt1, rt2|
      sort_topics(rt1, rt2)
    end
  end

  def self.created_by(user)
    where(user_id: user.id)
  end

  def self.newest(user_id = nil)
    viewable_by(user_id).order("created_at DESC")
  end

  # def self.random(user_id = nil)
  #   viewable_by(user_id).sample(3)
  # end

  def self.random(count)
    count = self.count if count > self.count #we can't ask for more records than we have
    self.offset(rand(self.count - count)).first(count)
  end




  # STATE GETTERS
  def proposed?
    state == 'proposed'
  end

  def active?
    state == 'active'
  end

  def completed?
    state == 'completed'
  end

  def removed?
    state == 'removed'
  end



  def last_activity_at
    updated_at #FIXME
  end

  private

  def self.sort_topics(rt1, rt2)
    comp = rt2.rating <=> rt1.rating
    comp.zero? ? (rt1.created_at <=> rt2.created_at) : comp
  end

end