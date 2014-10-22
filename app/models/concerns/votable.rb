module Votable
  extend ActiveSupport::Concern

  def rating
    votes.sum(:rating)
  end

  def has_vote?(user, rating)
    votes.where(user_id: user.id, rating: rating).count > 0
  end


  module ClassMethods
  end
end
