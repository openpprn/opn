class SessionsController < Devise::SessionsController;

  def initialize
    include_plugins
    super
  end


  private

  def sync_oodt_status
    current_user.sync_oodt_status(return_url: root_url) if current_user and OODT_ENABLED
  end


  def include_plugins
    self.class.send(:include, OODTSessionsController) if OODT_ENABLED
  end

end