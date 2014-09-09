class StaticController < ApplicationController

  def content
    @page = params[:page]
    render "/static/content/#{@page}", :layout => "content"
  end

end
