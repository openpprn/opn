require 'test_helper.rb'

class SocialControllerTest < ActionController::TestCase
  test "Logged-in User can access the social overview page" do
    get :overview

    assert_response 302

    login(users(:user_2))

    get :overview

    assert_response :success


  end

  test "User can view own social profile" do
    get :profile

    assert_response 302

    login(users(:user_1))

    get :profile

    assert_response :success
  end


  test "User can edit own social profile" do
    login(users(:user_1))
    profile_params = {social_profile: {name: "Bobby Valentine", location: "Anywhere, ND", age: 66, sex: "Male", photo: fixture_file_upload('../../test/support/rails.png')}}

    get :profile

    post :update_profile, profile_params
    assert_equal "Updated Successfully!", flash[:notice]

    assert_not_nil assigns(:social_profile)

    users(:user_1).reload

    assert_equal File.join(CarrierWave::Uploader::Base.root.call, 'uploads', 'social_profile', 'photo', assigns(:social_profile).id.to_s, 'rails.png'), assigns(:social_profile).photo.path

    assert users(:user_1).social_profile
    assert_equal profile_params[:social_profile][:name], users(:user_1).social_profile.name
  end

  test "should not allow user to save profile with non-unique name" do
    login(users(:user_1))

    post :update_profile, social_profile: { name: 'tom haverford' }

    assert_not_nil assigns(:social_profile)
    assert assigns(:social_profile).errors.size > 0
    assert_equal ["has already been taken"], assigns(:social_profile).errors[:name]

    assert_template 'profile'
    assert_response :success
  end

  test "List of locations of opted in users is available" do


    get :locations, format: :json

    assert assigns(:locations)
    assert_equal 6, assigns(:locations).length
    assert_includes assigns(:locations), {latitude: social_profiles(:show_1).latitude, longitude: social_profiles(:show_1).longitude}
  end

  test "Current user's location is available seperately from location list if opted in" do
    login(users(:social))

    get :locations, show_user: true, format: :json

    assert_equal 5, assigns(:locations).length
    assert_equal({latitude: users(:social).social_profile.latitude, longitude: users(:social).social_profile.longitude, title: users(:social).social_profile.name }, assigns(:user_location))
  end

  # Forums

  test "Forums should be visible to non-logged in user" do
    get :discussion, use_route: :forem

    assert_response :success
  end
end
