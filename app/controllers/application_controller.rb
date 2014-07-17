class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :determine_pprn


  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || research_path
  end



  def determine_pprn
    if Rails.env.production?
      determine_pprn_from_subdomain
    else
      determine_pprn_from_cookie
    end

    # Grab the PPRN Specifics from the YAML file

    @pprn_code = @pprn["code"]
    @pprn_title = @pprn["title"]
    @pprn_condition = @pprn["condition"]
    @pprn_conditions = @pprn["conditions"]
    @pprn_research_questions = @pprn["research_questions"]
    @pprn_research_team = @pprn["research_team"]
    @pprn_patient_team = @pprn["patient_team"]
    @pprn_surveys = @pprn["surveys"]
  end

  def determine_pprn_from_subdomain
    if request.subdomain == "myapnea"
      @pprn = PPRNS["myapnea"]
    else
      @pprn = PPRNS["ccfa"]
    end
  end

  def determine_pprn_from_cookie
    # if no cookie, has been set, let's assume it's myapnea
    cookies[:pprn] = "myapnea" if !cookies[:pprn]
    # read the existing cookie
    @pprn = PPRNS[cookies[:pprn]]
  end

  # Toggle the PPRN from CCFA <-> myapnea
  def toggle_pprn_cookie
    if cookies[:pprn] == "ccfa"
      cookies[:pprn] = "myapnea"
    elsif cookies[:pprn] == "myapnea"
      cookies[:pprn] = "ccfa"
    end

    redirect_to root_path
  end

end
