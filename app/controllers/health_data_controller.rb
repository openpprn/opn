class HealthDataController < ApplicationController
  before_action :authenticate_user!, :only => [:data_explore, :data_reports, :medications]
  before_action :set_active_top_nav_link_to_health_data
  before_action :validate_oodt_module, :only => [:explore, :reports]
  before_action :validate_validic_module, :only => []

  layout "health_data"

  def validate_oodt_module
    raise "OODT must be enabled for this feature." if !Figaro.env.oodt_enabled
  end

  def validate_validic_module
    raise "Validic must be enabled for this feature." if !Figaro.env.validic_enabled
  end

  def my_dashboard
    @med_list = current_user ? current_user.get_med_list : {}
  end

  def my_health_measures
    @chart_urls = current_user ? current_user.get_chart_urls : {}
  end

end
