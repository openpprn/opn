class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  authorize_actions_for User, only: [:add_role_to_user, :remove_role_from_user, :destroy_user], actions: {add_role_to_user: :update, remove_role_from_user: :update, destroy_user: :delete}

  ## Remote Actions
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


  ## Refactored

  def users
    set_users
  end

  def blog

  end

  def research_topics

  end

  def surveys

  end

  def notifications

  end


  private

  def authenticate_admin
    raise Authority::SecurityViolation.new(current_user, 'administrate', action_name) unless current_user.can?(:view_admin_dashboard)
  end

  def set_users
    @users = User.scoped_users(params[:search], params[:search_role])
  end


end
