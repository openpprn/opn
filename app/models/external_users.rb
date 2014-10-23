module ExternalUsers
  # http://api.rubyonrails.org/classes/ActiveSupport/Concern.html

  extend ActiveSupport::Concern

  # Configure your application to use OODT and/or Validic in config/initalizers/pprn.rb
  include OODTUser if OODT_ENABLED
  include ValidicUser if VALIDIC_ENABLED

  included do
    after_create :provision_external_users
  end

  def oodt_user?
    OODT_ENABLED && oodt_user_provisioned?
  end

  def validic_user?
    VALIDIC_ENABLED && validic_user_provisioned?
  end

  def provision_external_users
    provision_oodt_user if OODT_ENABLED
    provision_validic_user if VALIDIC_ENABLED
  end

  def delete_external_users
    delete_oodt_user if OODT_ENABLED
    delete_validic_user if VALIDIC_ENABLED
  end

  module ClassMethods
    def provision_all_external_users
      self.all.each { |u| u.provision_external_users }
    end

    def delete_all_external_users
      self.all.each { |u| u.delete_external_users }
    end
  end

end