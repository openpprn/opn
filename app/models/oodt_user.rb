module OODTUser

  # To automatically provision OODT account on user hook, add it to User.rb like so:
  # after_create :provision_oodt_user


  ####################
  # API CONNECTION SETUP
  ####################
  private def oodt
    conn = Faraday.new(url: "https://whiterivercomputing.com/pcori-1")
    conn.basic_auth(Figaro.env.oodt_username, Figaro.env.oodt_password)
    conn
  end

  # Base Params for any User OODT Call
  private def user_hash
    {userID: self.oodt_id}
  end

  def parse_body(response)
    JSON.parse(response.body)
  end


  ###################
  # USER PROVISIONING
  ###################
  def provision_oodt_user #2
    response = oodt.post "users/@@create", {:opnUserID => self.id} #not needed

    if response.success?
      body = parse_body(response)
      self.oodt_id = body['participantID']
    else
      logger.error "API Call to OODT to provision user ##{self.id} was unsucccessful. OODT returned the following response:\n#{response.inspect}"
      return false
    end
  end


  def oodt_status #6
    #response = oodt.post "documents/@@latestConsentGiven", user_hash

    # if response.success?
    #   body = parse_body(response)
    #   return body['status']
    # else
    #   logger.error "Unsuccessful OODT Status"
    #   return false
    # end
    return true
  end

  def signed_consent?

  end


  def pair_with_legacy_ccfa_partners_account(email) #3
    response = oodt.post "users/@@link", user_hash.merge!({email: email})

    if response.success?
      body = parse_body(response)
      return body['message']  # ...body['matchedEmail'] doing nothing with this now, but we could at least marked in the DB that this user was matched, so we don't ask them to again?
    else
      logger.error "API Call to pair user ##{self.id} with legacy ccfa partners account was unsucccessful. OODT returned the following response:\n#{response.inspect}"
      return false
    end
  end


  # Test if our local database knows the user is provisioned on OODT
  def oodt_user?
    return !self.oodt_id.nil?
  end



  ###############
  # SURVEYS
  ###############

  def surveys
    data = [ {url: "https://...", surveyID: 1, deadline: "2014-08-22T10:12:34.771672", title: "A Survey"},
             {url: "https://...", surveyID: 1, deadline: "2014-08-22T10:12:34.771672", title: "A Survey"},
             {url: "https://...", surveyID: 1, deadline: "2014-08-22T10:12:34.771672", title: "A Survey"}
           ]
  end

  def surveys_completed
    data = [ {url: "https://...", surveyID: 1, deadline: "2014-08-22T10:12:34.771672", title: "A Survey"},
             {url: "https://...", surveyID: 1, deadline: "2014-08-22T10:12:34.771672", title: "A Survey"},
             {url: "https://...", surveyID: 1, deadline: "2014-08-22T10:12:34.771672", title: "A Survey"}
           ]
  end

  def num_surveys_completed
    4
  end

  def num_surveys_available_since(datetime)
    10
  end






  ###############
  # HEALTH DATA
  ###############


  #### STREAMS ####
  def health_streams
    data = [ {source: "Name of Source 1", description: "Description 1", title: "Title 1", numberAvailable: 99, id: 1, sortKey: 1, latest: "2014-08-22T10:12:34.771672"},
            {source: "Name of Source 2", description: "Description 2", title: "Title 2", numberAvailable: 99, id: 1, sortKey: 1, latest: "2014-08-22T10:12:34.771672"},
            {source: "Name of Source 3", description: "Description 3", title: "Title 3", numberAvailable: 99, id: 1, sortKey: 1, latest: "2014-08-22T10:12:34.771672"}
          ]
  end

  def health_stream_data
    data = {element: "Name of Source 1", values: [0,1,2,3,4,5,4,3,2,1,0,1,2,3,4,5,4,3,2,1] }
  end


  #### ATTRIBUTES ####
  def health_attributes
    data = [ "Blood Type", "Age", "Weight"]
  end

  def health_attribute_data
    data = [
             {element: 1, value: {zones: [{startValue: 1, endValue: 888, title: "Low"}, {startValue: 300, endValue: 999, title: "High"}], markers: [{value: 1, title: "User Max"}, {value: 2, title: "User Average"}], value: 500}},
             {element: 2, value: {zones: [{startValue: 1, endValue: 200, title: "Low"}, {startValue: 900, endValue: 999, title: "High"}], markers: [{value: 1, title: "Yesterday"}, {value: 2, title: "Last Week"}], value: 500}},
             {element: 3, value: {zones: [{startValue: 1, endValue: 100, title: "Low"}, {startValue: 700, endValue: 999, title: "High"}], markers: [{value: 1, title: "Perfect"}, {value: 2, title: "See a Doctor"}], value: 500}}
            ]
  end


  #### TREAMENTS ####
  def treatments
    "Treament 1, Treatment 2, Treatment 3, Treatment 4"
  end

  def treatment_update_url
    "http://url_to_update_your_treatments"
  end



  #### OODT CALLS REGARDING VALIDIC DATA ####
  def send_validic_credentials_to_oodt #20 #required if using validic and oodt
    return false
  end

  def connected_devices
    data = [ {url: "https://...", title: "Device 1"},
             {url: "https://...", title: "Device 2"},
             {url: "https://...", title: "Device 3"}
           ]
  end

  def num_connected_devices
    3
  end





  def self.oodt_locations
    data = [ "Dogstown, MA", "Brooksfield", "Ohio", "UK", "Ko Pha Ngan", "Tennessee, USA", "America", "The Earth"]
  end





  #Notes, test the OODT API with the following line
  #curl -v --user 'patientportal:PW' 'https://whiterivercomputing.com/pcori-1/users/@@create?opnUserID=44'

end
