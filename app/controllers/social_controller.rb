class SocialController < ApplicationController
  before_action :authenticate_user!, except: [:locations, :discussion]
  before_action :set_active_top_nav_link_to_social

  def profile
    @social_profile = current_user.social_profile || current_user.create_social_profile
  end

  def update_profile
    @social_profile = current_user.social_profile

    if @social_profile.update(social_profile_params)
      flash[:notice] = "Updated Successfully!"
    end

    render :profile
  end


  def locations
    @locations = SocialProfile.locations_for_map(current_user)
    @user_location = current_user.social_profile.location_for_map if current_user and current_user.social_profile
  end

  private

  def social_profile_params

    params.require(:social_profile).permit(
        :name,
        :show_location,
        :show_karma,
        :location,
        :latitude,
        :longitude,
        :location_id,
        :age,
        :sex,
        :photo
    )
  end
end