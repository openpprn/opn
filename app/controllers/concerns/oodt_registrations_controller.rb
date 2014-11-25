module OODTRegistrationsController
  extend ActiveSupport::Concern


  included do
    skip_before_action :redirect_to_pairing_if_user_not_paired
  end

  module ClassMethods

  end



  def pairing_wizard #(email)
    #Try pairing to make sure everytime we run pairing_wizard we are working with the latest data
    try_pairing if !current_user.paired_with_lcp

    # Then render pairing page
  end

  def redirect_to_lcp_reg
    redirect_to current_user.get_lcp_reg_url(return_url: pairing_wizard_url)
    return
  end



  private

  def try_pairing #accepts optional URL param of email
    email_to_try = params[:email] || current_user.email

    if current_user.pair_with_lcp(email_to_try)
      flash[:success] = "Success! We linked your account with a Partners account that has the email address, #{email_to_try}. Wonderful!"
      #TODO: make this message be different if the user was automatically paired
    else
      flash[:notice] = "Your email address, #{email_to_try}, didn't match an existing CCFA Partners account. Please try pairing:"
    end

  end



end
