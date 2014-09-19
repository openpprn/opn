class AccountController < ApplicationController
  before_action :authenticate_user!, except: [:consent, :privacy_policy, :terms_and_conditions]

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

    end
  end


  def consent
    if params[:consent_read]
      redirect_to privacy_path
    elsif params[:consent_revoked]
      current_user.update_attribute(:accepted_consent_at, nil)
      redirect_to social_profile_path
    else

    end
  end

  def dashboard

  end

  def account
    @user = current_user
  end


  def terms_and_conditions
  end

  def update
    @user = User.find(current_user.id)

    if @user.update(user_params)
      redirect_to account_path, notice: "Your account settings have been successfully changed."
    else
      @update_for = :user_info
      render "account"
    end
  end

  def change_password
    @user = User.find(current_user.id)

    if @user.update_with_password(user_params)
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to account_path, alert: "Your password has been changed."
    else
      @update_for = :password
      render "account"
    end
  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.required(:user).permit(:email, :first_name, :last_name, :zip_code, :year_of_birth, :password, :password_confirmation, :current_password)
  end

end
