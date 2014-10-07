class BlogController < ApplicationController
  before_action :authenticate_user!, :only => [:new] #add authentication here where needed
  before_action :set_active_top_nav_link_to_blog


  def blog
    @posts = Post.blog_posts.viewable
  end

end

