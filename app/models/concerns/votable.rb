module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes
  end

  def rating
    votes.sum(:rating)
  end

  def has_vote?(user, rating)
    votes.where(user_id: user.id, rating: rating).count > 0
  end


  module ClassMethods
  end
end
