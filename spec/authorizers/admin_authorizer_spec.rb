# An authorizer shared by several admin-only models
describe AdminAuthorizer do

  before :each do
    @user  = build(:user)
    @admin = build(:admin)
    @owner = build(:owner)
  end

  describe "User" do
    it "lets owners update roles" do
      expect(AdminAuthorizer).to be_rolifiable_by(@owner)
    end

    it "doesn't let admins update roles" do
      expect(AdminAuthorizer).not_to be_rolifiable_by(@admin)
    end

    it "doesn't let users update roles" do
      expect(AdminAuthorizer).not_to be_rolifiable_by(@user)
    end
  end

  describe "Question, QuestionFlow, QuestionEdge" do
    it "lets admins create" do

    end

    it "lets admins update" do

    end

    it "lets admins destroy" do

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