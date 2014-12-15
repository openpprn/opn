# config/initializers/koala.rb
# Simple approach
Koala::Facebook::OAuth.class_eval do
  def initialize_with_default_settings(*args)
    raise "application id and/or secret are not specified in the envrionment" unless ENV['fb_app_id'] && ENV['fb_app_secret']
    initialize_without_default_settings(ENV['fb_app_id'].to_s, ENV['fb_app_secret'].to_s, args.first)
  end

  alias_method_chain :initialize, :default_settings
end


begin
  FB_API = Koala::Facebook::API.new(Koala::Facebook::OAuth.new.get_app_access_token)
rescue
  FB_API = nil
end
