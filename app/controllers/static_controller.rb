class StaticController < ApplicationController

  def content
    @page = params[:page]
    render "/static/content/#{@page}", :layout => "content"
  end

  def home
    @active_top_nav_link = :home
    @posts = Post.blog_posts.viewable
    render layout: "community"
  end

end
