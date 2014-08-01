class AdminAuthorizer < ApplicationAuthorizer
  def self.readable_by?
    user_signed_in?
  end

  def self.createable_by?
    user.has_role? :admin

  end

  def self.updateable_by?
    user.has_role? :admin

  end

  def self.deletable_by?
    user.has_role? :admin

  end


end