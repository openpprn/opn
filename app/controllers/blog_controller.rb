class BlogController < ApplicationController
  before_action :authenticate_user!, :only => [] #add authentication here where needed
  before_action :set_active_top_nav_link_to_blog


  def blog
    @posts = Post.blog_posts.viewable
    @new_post = Post.new(post_type: "blog")
  end
end