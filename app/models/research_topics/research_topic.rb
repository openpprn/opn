class ResearchTopic < ActiveRecord::Base
  includes Votable

  STATES = [:under_review, :proposed, :accepted, :rejected, :complete, :hidden]

  def self.popular

    includes(:votes).sort do |rt1, rt2|
      sort_topics(rt1, rt2)
    end
  end

  def self.voted_by(user)
    includes(:votes).where(user_id: user.id).select{|rt| rt.rating == 1}.sort do |rt1, rt2|
      sort_topics(rt1, rt2)
    end
  end

  def self.new
    includes(:votes).sort do |rt1, rt2|
      rt1.created_at <=> rt2.created_at
    end
  end

  private

  def sort_topics(rt1, rt2)
    comp = rt2.rating <=> rt1.rating
    comp.zero? ? (rt1.created_at <=> rt2.created_at) : comp
  end

end