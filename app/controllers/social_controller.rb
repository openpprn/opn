class SocialController < ApplicationController
  before_action :authenticate_user!, :only => [:discussion,:profile]
  before_action :set_active_top_nav_link_to_social
end