# An authorizer shared by several admin-only models
describe AdminAuthorizer do

  before :each do
    @user  = FactoryGirl.build(:user)
    @admin = FactoryGirl.build(:admin)
  end

  describe "class" do
    it "lets admins update" do
      expect(AdminAuthorizer).to be_updatable_by(@admin)
    end

    it "doesn't let users update" do
      expect(AdminAuthorizer).not_to be_updatable_by(@user)
    end
  end

  describe "instances" do

    before :each do
      # A mock model that uses AdminAuthorizer
      @admin_resource_instance = mock_admin_resource
    end

    it "lets admins delete" do
      expect(@admin_resource_instance.authorizer).to be_deletable_by(@admin)
    end

    it "doesn't let users delete" do
      expect(@admin_resource_instance.authorizer).not_to be_deletable_by(@user)
    end

  end

end