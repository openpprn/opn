module OODTApplicationController
  extend ActiveSupport::Concern


  included do
    before_action :redirect_to_pairing_if_user_not_paired
  end

  module ClassMethods

  end


  def redirect_to_pairing_if_user_not_paired
    if current_user && !current_user.paired_with_lcp
      redirect_to pairing_wizard_path
      return
    end
  end


end
