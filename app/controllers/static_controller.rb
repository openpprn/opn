class StaticController < ApplicationController

  def home
    @pc = YAML.load_file(Rails.root.join('lib', 'data', 'content', "home.#{I18n.locale}.yml"))['en']['home']

    @research_qs = Group.find_by_name("Research Questions").questions.sort_by{|q| -q.rating }
  end

  def privacy_policy
    @pc = YAML.load_file(Rails.root.join('lib', 'data', 'content', "privacy_policy.#{I18n.locale}.yml"))
  end

  def theme
    render layout: "theme"
  end

end
