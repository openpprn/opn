class AccountController < ApplicationController
  before_action :authenticate_user!

  authorize_actions_for User, only: :consent, actions: { consent: :update }

  def consent
    if params[:consent_signed]
      current_user.update_attribute(:accepted_consent_at, Time.zone.now)
      redirect_to account_path
    end
  end


end