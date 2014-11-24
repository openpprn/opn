class SessionsController < Devise::SessionsController;
  after_action :sync_oodt_status, only: [:create] ### CCFA PPRN ONLY
  skip_before_action :redirect_to_pairing_if_user_not_paired


  private

  def sync_oodt_status
    current_user.sync_oodt_status
  end

end