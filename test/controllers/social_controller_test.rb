require 'test_helper.rb'

class SocialControllerTest < ActionController::TestCase
  test "Anyone can access the social overview page" do
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
    profile_params = {social_profile: {name: "Bobby Valentine", location: "Anywhere, ND", age: 66, sex: "Male"}}

    get :profile

    post :update_profile, profile_params
    assert_equal "Updated Successfully!", flash[:notice]

    users(:user_1).reload
    assert users(:user_1).social_profile
    assert_equal profile_params[:social_profile][:name], users(:user_1).social_profile.name
  end
end