class PostAuthorizer < ApplicationAuthorizer
  def self.creatable_by?(user)
    user.has_role? :moderator
  end
  def self.updatable_by?(user)
    user.has_role? :moderator
  end
  def self.deletable_by?(user)
    user.has_role? :moderator
  end

  def self.readable_by?(user)
    user.has_role? :moderator
  end

  def updatable_by?(user)
    user.has_role? :moderator || resource.user == user
  end

  def deletable_by?(user)
    user.has_role? :moderator || resource.user == user
  end

  def readable_by?(user)
    user.has_role? :moderator || resource.user == user || resource.state == 'accepted'
  end
end