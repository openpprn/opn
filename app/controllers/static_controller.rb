class StaticController < ApplicationController

  def privacy_policy
    @pc = YAML.load_file(Rails.root.join('lib', 'data', 'content', "privacy_policy.#{I18n.locale}.yml"))
  end

  def theme
    render layout: "theme"
  end

end
