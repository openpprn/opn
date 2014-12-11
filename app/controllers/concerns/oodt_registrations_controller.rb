module OODTRegistrationsController
  extend ActiveSupport::Concern


  included do
    skip_before_action :redirect_to_pairing_if_user_not_paired
  end

  module ClassMethods

  end



  def pairing_wizard #(optional param: email)
    #Try pairing to make sure everytime we run pairing_wizard we are working with the latest data\
    try_pairing(params[:email]) if !current_user.paired_with_lcp

    # Then render pairing page
  end

  def redirect_to_lcp_reg
    redirect_to current_user.get_lcp_reg_url(return_url: pairing_wizard_url)
    return
  end




  private

  def try_pairing(alt_email) #accepts optional URL param of email

    email_to_try = alt_email || current_user.email

    if current_user.pair_with_lcp(email_to_try)
      flash.now[:notice] = "Success! We found that your email address, #{email_to_try}, matches an existing CCFA Partners account. Wonderful! We've connected them automatically to save you time entering data."
      #TODO: make this message be different if the user was automatically paired
    elsif alt_email
      flash.now[:notice] = "Your email address, #{email_to_try}, didn't match an existing CCFA Partners account. Would you like to try another email?"
    end
  end



end
