class ResearchController < ApplicationController
  before_action :authenticate_user!, :only => [:research_karma, :research_surveys]
  before_action :set_active_top_nav_link_to_research

  before_action :fetch_notifications

  #layout "community"
  layout "research"

  def fetch_notifications
    @posts = Post.notifications.viewable.all
  end

  def index
    @research_topics_popular = ResearchTopic.popular.page params[:popular_page]
    @research_topics_most_discussed = ResearchTopic.most_discussed.page params[:most_discussed_page]
    @research_topics_newest = ResearchTopic.newest.page params[:newest_page]
  end

  def my_contributions
    @research_access_events = current_user ? current_user.get_research_access_events : []
    @survey_scorecard = current_user ? current_user.get_survey_scorecard : []
  end

end