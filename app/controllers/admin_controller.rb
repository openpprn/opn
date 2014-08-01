class AdminController < ApplicationController
  before_filter :authenticate_user!


  def dashboard
    set_users
    
    @tab = params[:tab] || 'users'
    
    respond_to do |format|
      format.html
      format.js { render "users" }
    end


  end

  def add_role_to_user
    User.find(params[:user_id]).add_role Role.find(params[:role_id]).name

    set_users

    render "user_role"
  end

  def remove_role_from_user
    User.find(params[:user_id]).remove_role Role.find(params[:role_id]).name

    set_users

    render "user_role"
  end


  def set_users
    @users = User.all
  end



end
