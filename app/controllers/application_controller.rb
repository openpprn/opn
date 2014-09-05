class ApplicationController < ActionController::Base
  #layout 'myapnea/myapnea'
  layout :myapnea_layout

  def forem_user
    current_user
  end

  helper_method :forem_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :determine_pprn



  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || user_dashboard_path
  end

  # Send 'em back where they came from with a slap on the wrist
  def authority_forbidden(error)
    Authority.logger.warn(error.message)
    redirect_to request.referrer.presence || root_path, :alert => "Sorry! You attempted to visit a page you do not have access to. If you believe this message to be unjustified, please contact us at <support@myapnea.org>."
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
    @pprn = PPRNS["myapnea"]
  end

  def determine_pprn_from_cookie
    @pprn = PPRNS["myapnea"]
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



  def set_active_top_nav_link_to_research
    @active_top_nav_link = :research
  end

  def set_active_top_nav_link_to_health_data
    @active_top_nav_link = :health_data
  end

  def set_active_top_nav_link_to_social
    @active_top_nav_link = :social
  end

  def set_active_top_nav_link_to_blog
    @active_top_nav_link = :blog
  end

  def no_layout
    render layout: false
  end


  def myapnea_layout
    if (['research', 'surveys', 'health_data', 'social'].include? params[:controller] or params[:action] == "dashboard" or params[:action] == 'consent' or params[:action] == 'privacy_policy') and current_user
      'dashboard'
    elsif params[:action] == "privacy_policy" or params[:action] == "consent"
      Rails.application.config.layout
    elsif template_exists? params[:controller].split('/').last, 'layouts'
      params[:controller].split('/').last
    else
      Rails.application.config.layout
    end


  end


  def authenticate_research
    raise Authority::SecurityViolation.new(current_user, 'research', action_name) unless current_user.can?(:participate_in_research)
  end

end
