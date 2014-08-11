class HealthDataController < ApplicationController
  before_action :authenticate_user!, :only => [:data_explore, :data_reports]
  before_action :set_active_top_nav_link_to_health_data
end