module ExternalAccounts
  extend ActiveSupport::Concern


  included do
    #after_create :provision_external_accounts

    # Configure your application to use OODT and/or Validic in config/initalizers/pprn.rb
    include OODT if OODT_ENABLED
    include ValidicAdapter if Figaro.env.validic_enabled

    has_one :external_account, dependent: :destroy, autosave: true;
    delegate :oodt_id, :oodt_id=, :oodt_baseline_survey_complete, :oodt_baseline_survey_complete=, :oodt_baseline_survey_url, :oodt_baseline_survey_url=, :validic_id, :validic_id=, :validic_access_token, :validic_access_token=, to: :external_account, allow_nil: true
    # FIXME would prefer there to be a delegate all option
  end


  module ClassMethods
    def provision_all_external_accounts
      self.all.each { |u| u.provision_external_users }
    end

    def delete_all_external_accounts
      self.all.each { |u| u.delete_external_users }
    end
  end




  def oodt_user?
    OODT_ENABLED && oodt_user_provisioned?
  end

  def validic_user?
    Figaro.env.validic_enabled && validic_user_provisioned?
  end



  # def provision_external_accounts
  #   create_oodt if OODT_ENABLED
  #   provision_validic_user if Figaro.env.validic_enabled
  # end

  # def delete_external_accounts
  #   delete_oodt_user if OODT_ENABLED
  #   delete_validic_user if Figaro.env.validic_enabled
  # end


end