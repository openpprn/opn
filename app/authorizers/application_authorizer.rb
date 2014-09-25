# Other authorizers should subclass this one
class ApplicationAuthorizer < Authority::Authorizer

  # Any class method from Authority::Authorizer that isn't overridden
  # will call its authorizer's default method.
  #
  # @param [Symbol] adjective; example: `:creatable`
  # @param [Object] user - whatever represents the current user in your app
  # @return [Boolean]
  def self.default(adjective, user)
    # 'Whitelist' strategy for security: anything not explicitly allowed is
    # considered forbidden.
    false
  end


  def self.authorizes_to_view_admin_dashboard?(user, options = {})
    user.has_role?(:owner) || user.has_role?(:admin) || user.has_role?(:moderator)
  end

  def self.authorizes_to_participate_in_research?(user, options={})
    user.signed_consent?
  end

  def self.authorizes_to_participate_in_social?(user, options={})
    user.social_profile.present? and user.social_profile.name.present?
  end


end
