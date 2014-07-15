class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :determine_pprn


  def after_sign_in_path_for(resource)
    consent_path
  end



  def determine_pprn
    if Rails.env.production?
      determine_pprn_from_subdomain
    else
      determine_pprn_from_cookie
    end
  end

  def determine_pprn_from_subdomain
    if request.subdomain == "sapcon" || request.subdomain == "sleepapnea"
      # SAPCON
      @pprn = "sapcon"
      @pprn_title = "SAPCON"
      @pprn_condition = "Sleep Apnea"
    else
      # CCFA
      @pprn = "ccfa"
      @pprn_title = "CCFA PPRN"
      @pprn_condition = "Crohn's & Colitis"
    end
  end

  def determine_pprn_from_cookie
    cookies[:pprn] = "sapcon" if !cookies[:pprn]

    @pprn = cookies[:pprn]

    if @pprn == "ccfa"
      # CCFA
      @pprn_title = "CCFA PPRN"
      @pprn_condition = "Crohn's & Colitis"
    else @pprn == "sapcon"
      # SAPCON
      @pprn_title = "SAPCON"
      @pprn_condition = "Sleep Apnea"
    end
  end

  #Toggle the PPRN from CCFA <-> SAPCON
  def toggle_pprn_cookie
    if cookies[:pprn] == "ccfa"
      cookies[:pprn] = "sapcon"
    elsif cookies[:pprn] == "sapcon"
      cookies[:pprn] = "ccfa"
    end

    redirect_to root_path
  end

end
