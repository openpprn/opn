class PagesController < ApplicationController
  before_action :authenticate_user!, :only => [:account, :admin, :data, :connections, :new_question]
  before_action :set_active_nav_link_to_research, :only => [:research, :surveys, :research_question]
  before_action :set_active_nav_link_to_data, :only => [:data, :connections, :data_learn, :data_reports]
  before_action :set_active_nav_link_to_patients, :only => [:social, :social_profile, :discussion]
  before_action :set_active_nav_link_to_blog, :only => [:blog, :findings]





  def research
    @page_is_for_research = true;
  end

  def surveys
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
