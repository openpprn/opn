class StaticController < ApplicationController

  def home
    @pc = page_content('home')#YAML.load_file(Rails.root.join('lib', 'data', 'content', "home.#{I18n.locale}.yml"))['en']['home']

    @research_qs = Group.find_by_name("Research Questions").questions.sort_by{|q| -q.rating }
  end

  def learn
    @pc = page_content('learn') #.load_file(Rails.root.join('lib', 'data', 'content', "learn.#{I18n.locale}.yml"))['en']['learn']
  end

  def privacy_policy
    @pc = YAML.load_file(Rails.root.join('lib', 'data', 'content', "privacy_policy.#{I18n.locale}.yml"))
  end

  def theme
    render layout: "theme"
  end


  private

  def page_content(name)
    YAML.load_file(Rails.root.join('lib', 'data', 'content', "#{name}.#{I18n.locale}.yml"))[I18n.locale.to_s][name]
  end
end

