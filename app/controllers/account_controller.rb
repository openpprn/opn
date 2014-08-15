class AccountController < ApplicationController
  before_action :authenticate_user!

  # def consent
  #   if params[:consent_signed] && current_user
  #     current_user.update_attribute(:accepted_consent_at, Time.zone.now)
  #     redirect_to thank_you_path
  #   else
  #     @pc = YAML.load_file(Rails.root.join('lib', 'data', 'content', "consent.#{I18n.locale}.yml"))
  #     render layout: 'myapnea'
  #   end
  # end
  @pc = YAML.load_file(Rails.root.join('lib', 'data', 'content', "consent.#{I18n.locale}.yml"))

end