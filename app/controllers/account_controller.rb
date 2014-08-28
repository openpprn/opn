class AccountController < ApplicationController
  before_action :authenticate_user!

  authorize_actions_for User, only: :consent, actions: { consent: :update }

  def consent
    if params[:consent_signed]
      current_user.update_attribute(:accepted_consent_at, Time.zone.now)
      redirect_to user_dashboard_path
    elsif params[:consent_revoked]
      current_user.update_attribute(:accepted_consent_at, nil)
      redirect_to user_dashboard_path
    else
      @pc = YAML.load_file(Rails.root.join('lib', 'data', 'content', "consent.#{I18n.locale}.yml"))
    end
  end

  def dashboard

  end

  def terms_and_conditions
    render layout: 'dashboard'
  end

end
