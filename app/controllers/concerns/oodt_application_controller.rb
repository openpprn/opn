module OODTApplicationController
  extend ActiveSupport::Concern

  included do
    before_action :redirect_to_pairing_if_user_not_paired
    #before_action :redirect_to_complete_baseline_survey_if_incomplete
  end

  module ClassMethods

  end


  def redirect_to_pairing_if_user_not_paired
    if current_user && !current_user.paired_with_lcp
      redirect_to pairing_wizard_path
      return
    end
  end

  # def redirect_to_complete_baseline_survey_if_incomplete
  #   if current_user && !current_user.completed_baseline_survey
  #     redirect_to completed_baseline_survey_landing
  #     return
  #   end
  # end


end
