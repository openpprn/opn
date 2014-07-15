class PagesController < ApplicationController
  before_action :authenticate_user!, :only => [:account, :admin, :connections, :data, :discussion, :new_question]
  layout 'pages'


  def index; @hide_page_header = true; end
  def join; @hide_page_header = true; end
  def login; @hide_page_header = true; end
  def research_question; @hide_page_header = true; end

  # Prototype Pages
  # def account; end
  # def admin; end
  # # def blog; end
  # def connections; end
  def data; @page_title = "My Health Data"; end
  # def discussion; end
  def external_link_warning; @hide_page_header = true; end
  # def findings; end

  # def index; @hide_page_header = true; end
  # # def insights; end
  # def join; @hide_page_header = true; end
  # def login; @hide_page_header = true; end
  # # def new_question; end
  # #def pp-addons; end
  def research; @hide_page_header = true; end
  # def research_question; @hide_page_header = true; end
  def social; @page_title = "Patients"; end
  # def survey; end



  #Toggle the PPRN from CCFA <-> SAPCON
  def req
    if cookies[:req] == "false"
      cookies[:req] = "true"
    else
      cookies[:req] = "false"
    end
    redirect_to root_path
  end


end
