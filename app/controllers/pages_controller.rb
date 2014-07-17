class PagesController < ApplicationController
  before_action :authenticate_user!, :only => [:account, :admin, :connections, :data, :discussion, :new_question]



  #Toggle the PPRN from ccfa <-> myapnea
  def req
    if cookies[:req] == "false"
      cookies[:req] = "true"
    else
      cookies[:req] = "false"
    end
    redirect_to root_path
  end


end
