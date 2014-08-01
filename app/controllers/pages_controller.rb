class PagesController < ApplicationController
  before_action :authenticate_user!, :only => [:account, :admin, :data, :connections, :new_question]
  before_action :set_active_nav_link_to_research, :only => [:research, :data, :surveys, :research_question, :connections]
  before_action :set_active_nav_link_to_patients, :only => [:social, :social_profile, :discussion]
  before_action :set_active_nav_link_to_blog, :only => [:blog, :findings]







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
