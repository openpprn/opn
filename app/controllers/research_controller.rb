class ResearchController < ApplicationController
  before_action :authenticate_user!, :only => [:research_karma, :surveys]
  before_action :set_active_top_nav_link_to_research
end