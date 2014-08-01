class AdminController < ApplicationController
  before_filter :authenticate_user!


  def dashboard
    set_users

    respond_to do |format|
      format.html
      format.js { render "users" }
    end
  end

  def add_role_to_user
    User.find(params[:user_id]).add_role params[:role]

    set_users

    render "users"
  end

  def remove_role_from_user
    User.find(params[:user_id]).remove_role params[:role]

    set_users

    render "users"
  end


  def set_users
    @users = User.search_by_email(params[:search])
  end



end
