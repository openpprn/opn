class PagesController < ApplicationController
  before_action :authenticate_user!, :only => [:account, :admin, :data, :connections, :new_question]
  before_action :set_active_nav_link_to_research, :only => [:research, :data, :surveys, :research_question, :connections]
  before_action :set_active_nav_link_to_patients, :only => [:social, :social_profile, :discussion]
  before_action :set_active_nav_link_to_blog, :only => [:blog, :findings]



  def set_active_nav_link_to_research
    @active_nav_link = :research
  end

  def set_active_nav_link_to_patients
    @active_nav_link = :patients
  end

  def set_active_nav_link_to_blog
    @active_nav_link = :blog
  end

  def research
    @page_is_for_research = true;
  end

  def surveys
    @page_is_for_research = true;
  end

  def data
    @page_is_for_research = true;
  end

  def connections
    @page_is_for_research = true;
  end


  #Show Requirement Flags?
  def req
    if cookies[:req] == "false"
      cookies[:req] = "true"
    else
      cookies[:req] = "false"
    end
    redirect_to root_path
  end

end
