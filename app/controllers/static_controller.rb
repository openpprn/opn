class StaticController < ApplicationController

  before_action :load_pc, only: [ :home, :learn, :share, :research, :team, :faqs, :privacy_policy ]

  def home
    @research_qs = Group.find_by_name("Research Questions").questions.sort_by{|q| -q.rating }
  end

  def theme
    render layout: "theme"
  end

  private

  def load_pc
    @pc = page_content(params[:action].to_s)
  end

  def page_content(name)
    YAML.load_file(Rails.root.join('lib', 'data', 'content', "#{name}.#{I18n.locale}.yml"))[I18n.locale.to_s][name]
  end
end

