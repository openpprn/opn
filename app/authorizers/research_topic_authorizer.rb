class ResearchTopicAuthorizer < ApplicationAuthorizer
  def self.creatable_by?(user)
    user.can?(:participate_in_social)
  end

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
    user.has_role?(:moderator) || resource.user == user || resource.accepted?
  end

  def votable_by?(user)
    resource.accepted? || resource.user == user
  end
end