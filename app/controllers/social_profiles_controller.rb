class SocialProfilesController < ApplicationController
  before_filter :authenticate_user!

  def edit

    @social_profile = current_user.social_profile || current_user.create_social_profile


  end

  def update
    #raise StandardError

    @social_profile = current_user.social_profile

    if @social_profile.update(social_profile_params)
      flash[:notice] = "Updated Successfully!"
    end

    render :edit
  end

  def locations
    @locations = SocialProfile.locations_for_map
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