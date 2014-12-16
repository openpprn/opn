class ResearchTopicAuthorizer < ApplicationAuthorizer
  # def self.creatable_by?(user)
  #   user.can?(:participate_in_social)
  # end
  # openpprn divergence

  def moderatable_by?(user)
    user.has_role? :moderator
  end



  def self.updatable_by?(user)
    user.has_role? :moderator
  end

  def self.deletable_by?(user)
    user.has_role? :moderator
  end

  def self.readable_by?(user)
    true
  end

  def updatable_by?(user)
    user.has_role?(:moderator) || resource.user == user
  end

  def deletable_by?(user)
    user.has_role?(:moderator) || resource.user == user
  end

  def readable_by?(user)
    true
    # even if a topic was marked as removed, we want links to still function and for the removable notice to be viewable
    # past implementation was: user.has_role?(:moderator) || resource.user == user || !resource.removed?
  end

  def votable_by?(user)
    true
  end
end