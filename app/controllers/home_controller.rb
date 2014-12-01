class HomeController < ApplicationController

  def index
    @active_top_nav_link = :home
    @posts = Post.blog_posts.viewable
    render layout: "community"
  end

end
