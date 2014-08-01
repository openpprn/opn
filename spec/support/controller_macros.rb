module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:active_user, password: "secret")
      sign_in User.find(user.id)
    end
  end
end