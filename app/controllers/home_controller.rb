class HomeController < ApplicationController

  def index
    @active_top_nav_link = :home
    @posts = Post.blog_posts.viewable

    @network_user_count = OODT_ENABLED ? User.get_network_user_count : User.count
    @surveys_completed_count = OODT_ENABLED ? User.num_network_surveys_completed : 0 #FIXME Question.answered.count?
    @health_data_streams_count = OODT_ENABLED ? User.num_health_data_streams : nil


    # REFACTOR ME -- efficient querying
    @patient_team = User.with_role(:patient_team).shuffle.first(6)
    @patient_posts = Post.blog_posts.where("user_id IN (?)", @patient_team.collect(&:id))
    @research_team = User.with_role(:research_team).shuffle.first(6)
    @research_posts = Post.blog_posts.where("user_id IN (?)", @research_team.collect(&:id))
    @tech_team = User.with_role(:tech_team).shuffle.first(6)
    @tech_posts = Post.blog_posts.where("user_id IN (?)", @tech_team.collect(&:id))
    @all_team = (@patient_team+@research_team+@tech_team).shuffle.first(6)
    @all_posts = Post.blog_posts.where("user_id IN (?)", @all_team.collect(&:id))
    @help_center_team = User.with_role(:help_center).shuffle.first(6)
    @help_center_posts = Post.blog_posts.where("user_id IN (?)", @help_center_team.collect(&:id))


    render layout: "community"
  end

end
