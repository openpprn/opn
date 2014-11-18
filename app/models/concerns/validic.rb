module Validic
  extend ActiveSupport::Concern


  module ClassMethods
    #FIXME need to factor out most of these methods into class methods, but time constraints
  end


  ####################
  # API CONNECTION SETUP
  ####################
  def validic
    conn = Faraday.new(:url => "https://api.validic.com/v1/organizations/#{Figaro.env.validic_organization_id}/")
  end

  def basic_data
    {access_token: Figaro.env.validic_access_token}
  end

  def basic_user_data
    {access_token: Figaro.env.validic_access_token, "user[uid]" => self.id}
  end

  def validic_app_marketplace_url
    "https://app.validic.com/#{Figaro.env.validic_organization_id}/#{self.validic_access_token}"
  end

  def check_validic_alive
    response = Faraday.get "https://api.validic.com/v1/organizations/#{Figaro.env.validic_organization_id}.json", basic_data
    response.success?
  end




  ###################
  # USER PROVISIONING
  ###################
  def provision_validic_user
    response = validic.post "users.json", basic_user_data

    if response.success?
      body = JSON.parse(response.body)
      self.validic_id = body['user']['_id']
      self.validic_access_token = body['user']['access_token']
      self.save
      #send_validic_credentials_to_oodt if self.oodt_user? #oodt does not currently have this API call up
    else
      logger.error "API Call to Validic to provision user ##{self.id} was unsucccessful. Validic returned the following response:\n#{response.body}"
      return false
    end

  end

  # Test if the user is provisioned on Validic
  def validic_user_provisioned?
    return (!self.validic_id.nil? && !self.validic_access_token.nil?)
  end


  def get_all_validic_users
    response = validic.get "users.json", basic_user_data
    if response.success?
      body = JSON.parse(response.body)
      # gather up all the ids into a flat array
      body["users"].collect { |u| u["_id"] }
    else
      logger.error "API Call to Validic to provision user ##{self.id} was unsucccessful. Validic returned the following response:\n#{response.body}"
      return false
    end
  end


  ###################
  # USER DELETION
  ###################
  def delete_validic_user(id = self.validic_id)
    response = validic.delete "users/#{id}.json", basic_data

    if response.success?
      self.validic_id = nil
      self.validic_access_token = nil
      self.save
    else
      logger.error "API Call to Validic to delete user ##{self.id} was unsucccessful. Validic returned the following response:\n#{response.body}"
      return false
    end

  end


  def delete_all_validic_users
    get_all_validic_users.each { |id| delete_validic_user(id) } if get_all_validic_users.present?
  end




end
