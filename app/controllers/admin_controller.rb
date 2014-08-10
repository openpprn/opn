class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :setup

  # ensure_authorization_performed
  #
  # authorize_actions_for User, actions: { dashboard: :update, add_role_to_user: :update, remove_role_from_user: :update }

  # User and Survey are focuses now
  # For user, we allow owner to update users

  authorize_actions_for User, only: [:add_role_to_user, :remove_role_from_user], actions: {add_role_to_user: :update, remove_role_from_user: :update}

  def setup
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

  private

  def set_users
    @users = (params[:search] ? User.search_by_email(params[:search]) : User.all)
  end



end
