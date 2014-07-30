class AdminController < ApplicationController
  before_filter :authenticate_user!


  def dashboard
    @users = User.all
  end

  def add_role_to_user

  end
end
