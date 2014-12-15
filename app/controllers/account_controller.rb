class AccountController < ApplicationController
  before_action :authenticate_user!, except: [:consent, :privacy_policy, :terms_and_conditions]

  # def view_consent
  #   @pc = YAML.load_file(Rails.root.join('lib', 'data', 'content', "consent.#{I18n.locale}.yml"))
  # end

  def privacy_policy
    if params[:privacy_policy_read]
      current_user.update_attribute(:accepted_privacy_policy_at, Time.zone.now)
      if current_user.ready_for_research?
        redirect_to (session[:return_to].present? ? session.delete(:return_to) : home_path), notice: "You have now signed the consent and are ready to participate in research. You can opt out any time by visiting your user account settings."
      else
        redirect_to consent_path, notice: "Please read over and accept the research consent before participating in research."
      end
    elsif params[:declined_to_participate]
      current_user.revoke_consent
      redirect_to home_path, notice: "You are not enrolled in research. If you ever change your mind, just visit your account settings to view the research consent and privacy policy again."
    else

    end
  end


  def consent
    if params[:consent_read]
      current_user.update_attribute(:accepted_consent_at, Time.zone.now)
      if current_user.ready_for_research?
        redirect_to (session[:return_to].present? ? session.delete(:return_to) : home_path), notice: "You have now signed the consent and are ready to participate in research."
      else
        redirect_to privacy_path, notice: "Please read over and accept the privacy policy before participating in research. You can opt out any time by visiting your user account settings."
      end
    elsif params[:declined_to_participate]
      current_user.revoke_consent
      redirect_to home_path, notice: "You are not enrolled in research. If you ever change your mind, just visit your account settings to view the research consent and privacy policy again."
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
