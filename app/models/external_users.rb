module ExternalUsers
  extend ActiveSupport::Concern

  def self.included(base)
    base.extend(ClassMethodss)
    base.after_create :provision_external_users
  end

  # Configure your application to use OODT and/or Validic in config/initalizers/pprn.rb
  include OODTUser if Figaro.env.oodt_enabled
  include ValidicUser if Figaro.env.validic_enabled



  def oodt_user?
    Figaro.env.oodt_enabled && oodt_user_provisioned?
  end

  def validic_user?
    Figaro.env.validic_enabled && validic_user_provisioned?
  end



  def provision_external_users
    provision_oodt_user if Figaro.env.oodt_enabled
    provision_validic_user if Figaro.env.validic_enabled
  end

  def delete_external_users
    delete_oodt_user if Figaro.env.oodt_enabled
    delete_validic_user if Figaro.env.validic_enabled
  end



  module ClassMethodss
    def provision_all_external_users
      self.all.each { |u| u.provision_external_users }
    end

    def delete_all_external_users
      self.all.each { |u| u.delete_external_users }
    end
  end

end