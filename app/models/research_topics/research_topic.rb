class ResearchTopic < ActiveRecord::Base
  include Votable
  has_many :votes, counter_cache: true

  acts_as_commentable

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

  scope :popular, -> { order(votes_count: :desc) }
  scope :most_discussed, -> { order(updated_at: :desc) } #make sure commenting touches the model
  scope :newest, -> { order(created_at: :desc) }

  # intentionally returns all now, to allow for future filtering (no filters needed at the moment):
  scope :viewable_by, lambda { |user_id| self.all}


  def self.popular_old(user_id = nil)

    self.includes(:votes).sort do |rt1, rt2|
      sort_topics(rt1, rt2)
    end
  end

  def self.voted_by(user)
    self.joins(:votes).where(votes: {user_id: user.id, rating: 1} ).sort do |rt1, rt2|
      sort_topics(rt1, rt2)
    end
  end

  def self.created_by(user)
    where(user_id: user.id)
  end

  def self.random(count)
    count = self.count if count > self.count #we can't ask for more records than we have
    self.offset(rand(self.count - count)).first(count)
  end




  # STATE GETTERS
  def proposed?
    state == 'proposed'
  end

  def active?
    state == 'under_study'
  end

  def completed?
    state == 'study_completed'
  end

  def removed?
    state == 'removed'
  end


  def self.top_research_topics(minimum_percentage)
    ActiveRecord::Base.connection.execute(
      "
        select
        rt.id research_topic_id,
              count(v.id) topic_votes,
        max(vc.total) total_votes,
        count(v.id)/(1.00 * max(vc.total)) vote_percentage

        from research_topics rt, (select count(*) total from votes where research_topic_id is not null) vc, votes v
        where v.research_topic_id = rt.id
        group by rt.id
        having count(v.id)/(1.00 * max(vc.total)) > #{minimum_percentage};
      "
    ).to_a
  end

  def self.ranks
    ActiveRecord::Base.connection.execute(
      "
        select
          rt.id research_topic_id,
          rt.created_at research_topic_created_at,
          count(v.id) topic_votes
        from research_topics rt
        left join votes v on v.research_topic_id = rt.id
        where rt.state = 'accepted'
        group by rt.id
        order by topic_votes desc, research_topic_created_at desc;
      "
    ).to_a

  end

  # alias as per Sean's specs
  def votes_count
    rating
  end

  def accepted?
    state == 'accepted'
  end

  # As per Sean's specs
  def rank
    self.class.ranks.index { |rank_hash| rank_hash['research_topic_id'].to_i == self.id } + 1
  end





  private

  def self.sort_topics(rt1, rt2)
    comp = rt2.rating <=> rt1.rating
    comp.zero? ? (rt2.created_at <=> rt1.created_at) : comp
  end

end