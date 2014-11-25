class RegistrationsController < Devise::RegistrationsController

  def initialize
    include_plugins
    super
  end

  def create
    @user = build_resource # Needed for Merit
    super
  end

  def update
    @user = resource # Needed for Merit
    super
  end


  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :year_of_birth, :zip_code, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :year_of_birth, :zip_code, :email, :password, :password_confirmation, :current_password)
  end



  private

  def include_plugins
    self.class.send(:include, OODTRegistrationsController) if Figaro.env.oodt_enabled?
  end

end

