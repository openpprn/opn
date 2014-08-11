class AdminController < ApplicationController
  before_filter :authenticate_user!

  authorize_actions_for User, only: [:add_role_to_user, :remove_role_from_user, :destroy_user], actions: {add_role_to_user: :update, remove_role_from_user: :update, destroy_user: :delete}


  def dashboard
    if current_user.can?(:view_admin_dashboard)
      set_users

      @tab = params[:tab] || 'users'

      respond_to do |format|
        format.html
        format.js { render "users" }
      end
    else
      raise Authority::SecurityViolation.new(current_user, 'view', 'admin_dashboard')
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

  def destroy_user
    user = User.find(params[:user_id])

    user.destroy unless user == current_user

    set_users

    render "users"
  end

  private

  def set_users
    @users = User.scoped_users(params[:search], params[:search_role])
  end



end
