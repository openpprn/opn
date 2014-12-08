namespace :util do
  desc "Update social profile permission columns"
  task :update_sp_permissions => :environment do
    sql = "update social_profiles set make_public = true where visible_to_community = true or visible_to_world = true or show_location = true;"
    ActiveRecord::Base.connection.execute(sql)
  end
end