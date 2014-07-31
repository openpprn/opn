class AdminAuthorizer < ApplicationAuthorizer
  def self.updatable_by?(user)
    user.has_role? :owner
  end

  def updatable_by?(user)
    resource == user
  end

end