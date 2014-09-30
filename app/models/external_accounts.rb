module ExternalAccounts

  #after_create :provision_user_on_third_party_services

  def provision_external_accounts
    provision_oodt_user
    provision_validic_user
  end


  def oodt_user?
    return !self.oodt_id.nil?
  end

  def validic_user?
    return (!self.validic_id.nil? && !self.validic_access_token.nil?)
  end




  ## OODT METHODS
  private def oodt
    conn = Faraday.new(:url => "https://whiterivercomputing.com/pcori-1")
    conn.basic_auth(Rails.application.secrets.oodt_username, Rails.application.secrets.oodt_password)
    conn
  end

  def provision_oodt_user
    #This code replicates:
    #curl -v --user 'patientportal:samasama146pcori' 'https://whiterivercomputing.com/pcori-1/users/@@create?opnUserID=44'
    response = oodt.post "users/@@create", {:opnUserID => self.id}

    if response.success?
      body = JSON.parse(response.body)
      self.oodt_id = body['participantID']
    else
      logger.error "API Call to OODT to provision user ##{self.id} was unsucccessful. OODT returned the following response:\n#{response}"
      return false
    end
  end

  private def send_validic_credentials_to_oodt
    # oodt.post "UNKNOWN"
  end





  ## VALIDIC METHODS
  private def validic
    conn = Faraday.new(:url => "https://api.validic.com/v1/organizations/#{Rails.application.secrets.validic_organization_id}/")
  end


  def provision_validic_user
    response = validic.post "users.json", {
      :access_token => "01e6f0829482d546b9d5889de97b54ca1c0655fc2fa5d82b2a2e73373cbde02a",
      "user[uid]" => self.id
    }

    if response.success?
      body = JSON.parse(response.body)
      self.validic_id = body['user']['_id']
      self.validic_access_token = body['user']['access_token']
      self.save
      #send_validic_credentials_to_oodt if self.oodt_user? #oodt does not currently have this API call up
    else
      logger.error "API Call to Validic to provision user ##{self.id} was unsucccessful. Validic returned the following response:\n#{response}"
      return false
    end

  end


  def validic_app_marketplace_url
    "https://app.validic.com/#{Rails.application.secrets.validic_organization_id}/#{self.validic_access_token}"
  end


  def check_validic_ok
    response = Faraday.get "https://api.validic.com/v1/organizations/#{Rails.application.secrets.validic_organization_id}.json?access_token=#{Rails.application.secrets.validic_access_token}"
  end


end
