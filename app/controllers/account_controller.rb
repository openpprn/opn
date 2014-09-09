class AccountController < ApplicationController
  before_action :authenticate_user!, except: [:consent, :privacy_policy]

  # def view_consent
  #   @pc = YAML.load_file(Rails.root.join('lib', 'data', 'content', "consent.#{I18n.locale}.yml"))
  # end

  def privacy_policy
    if params[:agreed_to_participate]
      current_user.update_attribute(:accepted_consent_at, Time.zone.now)
      redirect_to social_profile_path
    elsif params[:declined_to_participate]
      current_user.update_attribute(:accepted_consent_at, nil)
      redirect_to social_profile_path
    else
      load_content
    end
  end


  def consent
    if params[:consent_read]
      redirect_to privacy_path
    elsif params[:consent_revoked]
      current_user.update_attribute(:accepted_consent_at, nil)
      redirect_to social_profile_path
    else
      load_content
    end
  end

  def dashboard

  end

  def terms_and_conditions
    render layout: 'dashboard'
  end

  private

  def load_content
    nil

  end

end
