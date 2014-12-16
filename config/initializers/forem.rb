require 'emoji'
Forem.user_class = "User"
Forem.main_layout = "application"
Forem.admin_layout = "admin"
Forem.logged_in_layout = "community"
Forem.avatar_user_method = :photo_url
Forem.email_from_address = "#{ENV['website_title']} <#{ENV['smtp_email']}>"
Forem.per_page = 20
