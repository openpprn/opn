class RegistrationsController < Devise::RegistrationsController
  #after_action :create, :pair_with_lcp #(CCFAPPRN ONLY)
  # TODO FACTOR OUT INTO OODT CONCERN
  skip_before_action :redirect_to_pairing_if_user_not_paired

  def create
    @user = build_resource # Needed for Merit
    super
  end

  def update
    @user = resource # Needed for Merit
    super
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




  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :year_of_birth, :zip_code, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :year_of_birth, :zip_code, :email, :password, :password_confirmation, :current_password)
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
