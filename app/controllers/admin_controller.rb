class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_owner

  # ensure_authorization_performed
  #
  # authorize_actions_for User, actions: { dashboard: :update, add_role_to_user: :update, remove_role_from_user: :update }

  # User and Survey are focuses now
  # For user, we allow owner to update users

  authorize_actions_for User, only: [:add_role_to_user, :remove_role_from_user], actions: {add_role_to_user: :update, remove_role_from_user: :update}

  def authenticate_owner
    if !current_user.can?(:view_admin_dashboard)
      raise Authority::SecurityViolation.new(current_user, 'view', 'admin_dashboard')
    end
  end


  def admin_users
    @users = (params[:search] ? User.search_by_email(params[:search]) : User.all)
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


end
