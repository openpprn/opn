class ResearchTopic < ActiveRecord::Base
  include Votable
  has_many :votes

  include Authority::Abilities

  belongs_to :user

  STATES = [:under_review, :proposed, :accepted, :rejected, :complete, :hidden]

  scope :accepted, -> { where(state: 'accepted') }


  def self.popular

    accepted.includes(:votes).sort do |rt1, rt2|
      sort_topics(rt1, rt2)
    end
  end

  def self.voted_by(user)
    accepted.joins(:votes).where(votes: {user_id: user.id, rating: 1} ).sort do |rt1, rt2|
      sort_topics(rt1, rt2)
    end
  end

  def self.created_by(user)
    where(user_id: user.id)
  end

  def self.newest
    accepted.order("created_at DESC")
  end


  def accepted?
    state == 'accepted'
  end
  private

  def self.sort_topics(rt1, rt2)
    comp = rt2.rating <=> rt1.rating
    comp.zero? ? (rt1.created_at <=> rt2.created_at) : comp
  end

end