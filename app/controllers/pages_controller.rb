class PagesController < ApplicationController
  before_action :authenticate_user!, :only => [:account, :admin, :connections, :data, :discussion, :new_question]
  before_action :determine_pprn
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

  def determine_pprn
    @pprn = "ccfa"
    @pprn_title = "CCFA PPRN"
    @pprn_condition = "Crohn's & Colitis"
  end

  # Read the PPRN Cookie
  # def determine_pprn
  #   cookies[:pprn] = "sapcon" if !cookies[:pprn]

  #   @pprn = cookies[:pprn]

  #   if @pprn == "ccfa"
  #     # CCFA
  #     @pprn_title = "CCFA PPRN"
  #     @pprn_condition = "Crohn's & Colitis"
  #   else @pprn == "sapcon"
  #     # SAPCON
  #     @pprn_title = "SAPCON"
  #     @pprn_condition = "Sleep Apnea"
  #   end
  # end

  #Toggle the PPRN from CCFA <-> SAPCON
  def pprn
    if cookies[:pprn] == "ccfa"
      cookies[:pprn] = "sapcon"
    elsif cookies[:pprn] == "sapcon"
      cookies[:pprn] = "ccfa"
    end

    redirect_to root_path
  end

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
