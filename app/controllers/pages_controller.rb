class PagesController < ApplicationController
  before_action :authenticate_user!, :only => [:account, :admin, :data_explore, :data_connections, :data_reports, :new_question, :research_karma, :surveys]
  before_action :set_active_nav_link_to_research, :only => [:research_topics, :surveys, :research_question, :research_karma, :data_connections]
  before_action :set_active_nav_link_to_data, :only => [:data_explore, :data_learn, :data_reports]
  before_action :set_active_nav_link_to_patients, :only => [:social, :social_profile, :social_discussion]
  before_action :set_active_nav_link_to_blog, :only => [:blog, :blog_findings]




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
