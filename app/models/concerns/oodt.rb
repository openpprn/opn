module OODT
  extend ActiveSupport::Concern


  # To automatically provision OODT account on user hook, add it to User.rb like so:
  # after_create :provision_oodt_user

  module ClassMethods
    #FIXME need to factor out most of these methods into class methods, but time constraints
    def delete_all_oodt_users
      User.all.each { |u| u.delete_oodt_user }
    end
  end

  included do
    after_create :create_oodt
  end

  ####################
  # API CONNECTION SETUP
  ####################
  def oodt
    prefix = "api/pcori/sandbox/v1/"
    conn = Faraday.new(url: "https://whiterivercomputing.com/#{prefix}")
    conn.basic_auth(Figaro.env.oodt_username, Figaro.env.oodt_password)
    conn
  end

  # Base Params for any User OODT Call
  def user_hash
    {userID: self.oodt_id}
  end

  def parse_body(response)
    JSON.parse(response.body)
  end

  # Test if our local database knows the user is provisioned on OODT
  def oodt_user_provisioned?
    return !self.oodt_id.nil?
  end

  def paired_with_LCP
    oodt_id.present?
  end


  ###################
  # ACCOUNT SETUP
  ###################
  def create_oodt(email_to_try = self.email) #2
    response = oodt.post "users/@@create", {:email => email_to_try}
    body = parse_body(response)

    if response.success?
      store_basics(body)
      return body
    else
      logger.error "API Call to OODT to provision user ##{self.id} was unsucccessful. OODT returned the following response:\n#{response.body}"
      return body['errorMessage'] || body
    end
  end

  def refresh_oodt_status #6
    response = oodt.post "users/@@status", user_hash
    body = parse_body(response)

    if response.success?
      store_basics_type_b(body)
      return body
    else
      logger.error "API Call to OODT to get user status for ##{self.id} was unsucccessful. OODT returned the following response:\n#{response.body}"
      return body['errorMessage'] || body
    end
  end

  def get_LCP_reg_url
    response = oodt.post "users/@@registrationURL", {:email => email}
    body = parse_body(response)

    if response.success?
      return body['url']
    else
      logger.error "Unable to retrieve LCP reg URL for ##{self.id}. OODT returned the following response:\n#{response.body}"
      return body['errorMessage'] || body
    end
  end





  def store_basics(body)
    self.external_account = ExternalAccount.new if !external_account

    self.oodt_id = body['userID']
    self.oodt_baseline_survey_complete = true if body['status'] == "baselineSurveyComplete"
    self.oodt_baseline_survey_complete = false if body['status'] == "baselineSurveyIncomplete"
    self.oodt_baseline_survey_url = body['url']

    self.external_account.save
    return external_account
  end

  # Implementation for API Call #6
  def store_basics_type_b(body)
    oodt_baseline_survey_complete = body['baselineSurveyComplete']
    oodt_baseline_survey_url = body['url']

    self.external_account.save
    return external_account
  end





  ###################
  # USER DELETION
  ###################
  def delete_oodt_user
    response = oodt.post "users/@@delete", user_hash

    if response.success?
      self.oodt_id = nil
      self.save
    else
      logger.error "API Call to OODT to delete user ##{self.id} was unsucccessful. OODT returned the following response:\n#{response.body}"
      return false
    end

  end











  ###############
  # SURVEYS
  ###############
  def get_surveys #11
    response = oodt.post "users/@@surveys", user_hash
    body = parse_body(response)

    if response.success?
      surveyOpenDate = body['surveyDate']
      surveyURL = body['url']
      num_completed = body['completed'].count
      num_incompleted = body['incomplete'].count
      num_surveys = num_completed + num_incompleted
      return "The next survey opens on #{surveyOpenDate} at #{surveyURL}. The user has completed #{num_completed}/#{num_surveys} surveys"
    else
      logger.error "API Call to get surveys for user ##{self.id} failed. OODT returned the following response:\n#{response.body}"
      return body['errorMessage'] || body
    end
  end



  ###############
  # HEALTH DATA
  ###############

  #### MEDICATIONS ####
  def get_med_update_url #18
    response = oodt.post "users/@@medicationUpdateURL", user_hash
    body = parse_body(response)

    if response.success?
      return body['url']
    else
      logger.error "API Call to fetch med update url for user ##{self.id} failed. OODT returned the following response:\n#{response.body}"
      return body['errorMessage'] || body
    end
  end


  ## MEDICATIONS ####
  def get_med_list #19
    response = oodt.post "users/@@medications", user_hash
    body = parse_body(response)

    if response.success?
      current_as_of = body['date']
      meds = body['meds']
      return "Med List (as of #{current_as_of}): #{meds}"
    else
      logger.error "API Call to fetch med list for user ##{self.id} failed. OODT returned the following response:\n#{response.body}"
      return body['errorMessage'] || body
    end
  end



  ## RESEARCHER ACCESS LOG ####
  def get_research_access_events #19
    response = oodt.post "users/@@pubAnalyses", user_hash
    body = parse_body(response)

    if response.success?
      #[{"timestamp": "YYYY-MM-DD", "description": "DESCRIPTION", "status": "STATUS", "url": "URL"}, ...]
      return body
    else
      logger.error "API Call to fetch researcher access log for user ##{self.id} failed. OODT returned the following response:\n#{response.body}"
      return body['errorMessage'] || body
    end
  end



  ## MEDICATIONS ####
  def get_oodt_user_count #19
    response = oodt.post "users/@@count"
    body = parse_body(response)

    if response.success?
      return body['count']
    else
      logger.error "API Call to fetch oodt user count failed. OODT returned the following response:\n#{response.body}"
      return body['errorMessage'] || body
    end
  end




  ## RESET SANDBOX ####
  # requires date: current date in UTC
  def reset_sandbox(date) #19
    response = oodt.post "users/@@reset", {confirmation: date}

    if response.success?
      return "The OODT Sandbox has been reset"
    else
      logger.error "API call to reset sandbox failed, OODT returned the following response:\n#{response.body}"
      return body['errorMessage'] || body
    end
  end






  #### ATTRIBUTES ####
  def health_attributes
    data = [ "My Disease Activity", "My Quality of Life", "My Anxiety Symptoms"]
  end

  def health_attribute_data
    data = [
             {element: 1, title: "My Disease Activity", value: 500, zones: [{startValue: 1, endValue: 888, title: "Low"}, {startValue: 300, endValue: 999, title: "High"}], markers: [{value: 1, title: "User Max"}, {value: 2, title: "User Average"}] },
             {element: 2, title: "My Quality of Life", value: 300, zones: [{startValue: 1, endValue: 200, title: "Low"}, {startValue: 900, endValue: 999, title: "High"}], markers: [{value: 1, title: "Yesterday"}, {value: 2, title: "Last Week"}] },
             {element: 3, title: "My Anxiety Symptoms", value: 100, zones: [{startValue: 1, endValue: 100, title: "Low"}, {startValue: 700, endValue: 999, title: "High"}], markers: [{value: 1, title: "Perfect"}, {value: 2, title: "See a Doctor"}] },
             {element: 1, title: "My Depression Symptoms", value: 500, zones: [{startValue: 1, endValue: 888, title: "Low"}, {startValue: 300, endValue: 999, title: "High"}], markers: [{value: 1, title: "User Max"}, {value: 2, title: "User Average"}] },
             {element: 2, title: "My Fatigue Symptoms", value: 300, zones: [{startValue: 1, endValue: 200, title: "Low"}, {startValue: 900, endValue: 999, title: "High"}], markers: [{value: 1, title: "Yesterday"}, {value: 2, title: "Last Week"}] },
             {element: 3, title: "My Pain Symptoms", value: 100, zones: [{startValue: 1, endValue: 100, title: "Low"}, {startValue: 700, endValue: 999, title: "High"}], markers: [{value: 1, title: "Perfect"}, {value: 2, title: "See a Doctor"}] },
             {element: 1, title: "My Sleep Disturbances", value: 500, zones: [{startValue: 1, endValue: 888, title: "Low"}, {startValue: 300, endValue: 999, title: "High"}], markers: [{value: 1, title: "User Max"}, {value: 2, title: "User Average"}] },
             {element: 2, title: "My Social Relations", value: 300, zones: [{startValue: 1, endValue: 200, title: "Low"}, {startValue: 900, endValue: 999, title: "High"}], markers: [{value: 1, title: "Yesterday"}, {value: 2, title: "Last Week"}] },
             {element: 3, title: "My Anxiety Symptoms", value: 100, zones: [{startValue: 1, endValue: 100, title: "Low"}, {startValue: 700, endValue: 999, title: "High"}], markers: [{value: 1, title: "Perfect"}, {value: 2, title: "See a Doctor"}] }
           ]
  end








  def self.oodt_locations
    data = [ "Dogstown, MA", "Brooksfield", "Ohio", "UK", "Ko Pha Ngan", "Tennessee, USA", "America", "The Earth"]
  end


  #### OODT CALLS REGARDING VALIDIC DATA ####
  # def send_validic_credentials_to_oodt #20 #required if using validic and oodt
  #   return false
  # end

  # def connected_devices
  #   data = [ {url: "https://...", title: "Device 1"},
  #            {url: "https://...", title: "Device 2"},
  #            {url: "https://...", title: "Device 3"}
  #          ]
  # end

  # def num_connected_devices
  #   3
  # end






  #Notes, test the OODT API with the following line
  #curl -v --user 'patientportal:PW' 'https://whiterivercomputing.com/pcori-1/users/@@create?opnUserID=44'

end
