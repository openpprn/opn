class ResearchController < ApplicationController
  before_action :authenticate_user!, :only => [:research_karma, :research_surveys]
  before_action :set_active_top_nav_link_to_research
  before_action :no_layout, :only => [:research_questions, :vote_counter]

  def research_surveys
  end


  def new_research_topic
    @new_research_topic = ResearchTopic.new
  end

  def research_topic
    @research_topic = ResearchTopic.find(params[:id])
  end


end