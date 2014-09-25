class ResearchController < ApplicationController
  before_action :authenticate_user!, :only => [:research_karma, :research_surveys]
  before_action :set_active_top_nav_link_to_research
  before_action :authenticate_research, only: [:research_surveys]
  
  def research_surveys
  end


  def research_today
    @coming_soon = true
  end


end