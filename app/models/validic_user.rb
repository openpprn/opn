module ValidicUser

  # To automatically provision Validic account as a user callback, add it to User.rb like so:
  # after_create :provision_validic_user

  ####################
  # API CONNECTION SETUP
  ####################
  private def validic
    conn = Faraday.new(:url => "https://api.validic.com/v1/organizations/#{Figaro.env.validic_organization_id}/")
  end

  def check_validic_ok
    response = Faraday.get "https://api.validic.com/v1/organizations/#{Figaro.env.validic_organization_id}.json?access_token=#{Figaro.env.validic_access_token}"
  end

  def validic_app_marketplace_url
    "https://app.validic.com/#{Figaro.env.validic_organization_id}/#{self.validic_access_token}"
  end


  ###################
  # USER PROVISIONING
  ###################
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

  # Test if the user is provisioned on Validic
  def validic_user?
    return (!self.validic_id.nil? && !self.validic_access_token.nil?)
  end


end
