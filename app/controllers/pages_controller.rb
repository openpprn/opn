class PagesController < ApplicationController
  before_action :authenticate_user!, :only => [:account, :admin, :data, :connections, :new_question]
  before_action :specify_page_is_for_research, :only => [:research, :data]

  def specify_page_is_for_research
    @page_is_for_research = true
  end

  #Show Requirement Flags?
  def req
    if cookies[:req] == "false"
      cookies[:req] = "true"
    else
      cookies[:req] = "false"
    end
    redirect_to root_path
  end

end
