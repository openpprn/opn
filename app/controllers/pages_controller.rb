class PagesController < ApplicationController
  before_action :authenticate_user!
  layout 'pages'

  def account; end
  def admin; end
  def blog; end
  def connections; end
  def contributions; end
  def data; end
  def donate; end
  def health_profile; end
  def home; end
  def index; end
  def insights; end
  def join; end
  def login; end
  def new_question; end
  #def pp-addons; end
  def research; end
  def research_question; end
  def social; end
  def social_profile; end
  def survey; end

end
