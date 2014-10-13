class HealthDataController < ApplicationController
  before_action :authenticate_user!, :only => [:data_explore, :data_reports, :medications]
  before_action :set_active_top_nav_link_to_health_data
  before_action :validate_oodt_module, :only => [:explore, :reports]
  before_action :validate_validic_module, :only => []

def validate_oodt_module
  raise "OODT must be enabled for this feature." if !OODT_ENABLED
end

def validate_validic_module
  raise "Validic must be enabled for this feature." if !VALIDIC_ENABLED
end


end
