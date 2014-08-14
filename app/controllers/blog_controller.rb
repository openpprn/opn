class BlogController < ApplicationController
  before_action :authenticate_user!, :only => [] #add authentication here where needed
  before_action :set_active_top_nav_link_to_blog
end