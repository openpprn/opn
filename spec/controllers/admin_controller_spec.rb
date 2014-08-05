describe "AdminController" do

  describe 'POST #add_role_to_user' do
    context 'when current_user is an owner' do
      it 'adds role' do
        user = create(:owner)
        sign_in_user(user)

        post add_role_path

        expect(response).to render_template(:users)
      end
    end

    context 'when current_user is not an owner' do
      it 'raises a SecurityViolation' do
        user = create(:admin)
        sign_in_user(user)

        post add_role_path

        expect(response).to "be 403 forbidden"
      end
    end
  end

  describe 'POST #remove_role_from_user' do
    context 'when current_user is an owner' do
      it 'removes role' do
        pending
      end



    end

    context 'when current_user is not an owner' do
      it 'raises a Security Violation' do

      end
    end
  end

  describe 'GET #dashboard' do
    context 'when current_user is an owner or admin' do
      it "renders dashboard dashboard" do
        pending
      end

    end

    context 'when current_user is not an owner or admin' do
      it 'raises Security Violation' do

      end
    end
  end
end